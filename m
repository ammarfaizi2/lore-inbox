Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263988AbUDONvO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 09:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263908AbUDONvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 09:51:14 -0400
Received: from zero.aec.at ([193.170.194.10]:45067 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263988AbUDONvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 09:51:11 -0400
To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: why change_page_attr on x86 uses __flush_tlb_all
References: <1Lek1-5lB-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 15 Apr 2004 15:51:07 +0200
In-Reply-To: <1Lek1-5lB-3@gated-at.bofh.it> (Nagendra Singh Tomar's message
 of "Thu, 15 Apr 2004 14:40:09 +0200")
Message-ID: <m3smf5ic38.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagendra Singh Tomar <nagendra_tomar@adaptec.com> writes:

> 	I would expect __flush_tlb_one (for each page) as a better choice.
> It'll be nice if someone can hoghlight on  why __flush_tlb_all is used.
> The kernel version I am referring from is 2.4.18-14

This works around a bug in some early Athlons with flushing global
large pages. Also it makes the code slightly simpler and change_page_attr
is not really performance critical.

-Andi


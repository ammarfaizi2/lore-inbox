Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUDDL17 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 07:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUDDL17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 07:27:59 -0400
Received: from zero.aec.at ([193.170.194.10]:49161 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262311AbUDDL16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 07:27:58 -0400
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <1H9LV-5Jb-1@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 04 Apr 2004 13:27:44 +0200
In-Reply-To: <1H9LV-5Jb-1@gated-at.bofh.it> (Sergiy Lozovsky's message of
 "Sun, 04 Apr 2004 09:00:08 +0200")
Message-ID: <m3ad1s0yq7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergiy Lozovsky <serge_lozovsky@yahoo.com> writes:

> This function doesn't work in the kernel (system hungs
> instantly when my function is called). Does antbody
> have any idea what the reason can be? Some special
> alignment? Special memory segment? In what direction
> should I look?

The kernel puts some data about the current task at the bottom
of the stack and accesses that by referencing the stack pointer
in "current". This is even used by interrupts.

-Andi


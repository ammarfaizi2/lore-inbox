Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVAFU4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVAFU4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVAFUw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:52:58 -0500
Received: from one.firstfloor.org ([213.235.205.2]:29883 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S263016AbVAFUuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:50:18 -0500
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] kernel/printk.c  lockless access
References: <20050106195812.GL22274@austin.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 06 Jan 2005 21:50:17 +0100
In-Reply-To: <20050106195812.GL22274@austin.ibm.com> (Linas Vepstas's
 message of "Thu, 6 Jan 2005 13:58:12 -0600")
Message-ID: <m1llb6uvsm.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas <linas@austin.ibm.com> writes:

> The 'fix' is to provide a routine that simply returns the pointers
> to the log buffer.  

Better&simpler fix would be to just unstatic __log_buf
You cannot call such functions generally when looking at memory
dumps of some form.

-Andi

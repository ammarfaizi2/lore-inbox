Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVHKX0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVHKX0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 19:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVHKX0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 19:26:07 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:50138 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S932495AbVHKX0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 19:26:04 -0400
Date: Fri, 12 Aug 2005 01:25:56 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org, Ukil a <ukil_a@yahoo.com>
Subject: Re: Need help in understanding  x86  syscall
In-Reply-To: <1123769139.17269.50.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0508111652440.3191@be1.lrz>
References: <4Ae73-6Mm-5@gated-at.bofh.it>  <E1E3DJm-0000jy-0B@be1.lrz>
 <1123769139.17269.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Steven Rostedt wrote:
> On Thu, 2005-08-11 at 15:41 +0200, Bodo Eggert wrote:

> > According to my documentation it isn't. A software interrupt is a far call
> > with an extra pushf, and a hardware interrupt is protected against recursion
> > by the PIC, not by an interrupt flag.
> 
> I disagree with your definition of a system call.  The "int 0x80"
> changes from user mode to kernel mode so it is much more powerful than a
> "far call".

Far calls and jumps can change to a inner ring. This is done by a special
segment selector containing the segment _and_ the offset to jump to (the
offset from the call instruction is ignored).

>  Also the CPU does protect against recursion and more than
> one interrupt coming in at the same time. The PIC also works with the
> CPU in this regard, but as I shown in my previous email, the interrupt
> flag _does_ protect against it.

Showing == claiming? However, my documentation was wrong.

http://www.baldwin.cx/386htm/INT.htm
-- 
Top 100 things you don't want the sysadmin to say:
99. Shit!!

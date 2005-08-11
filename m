Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVHKOFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVHKOFs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVHKOFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:05:48 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:52870 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750710AbVHKOFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:05:47 -0400
Subject: Re: Need help in understanding  x86  syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org, Ukil a <ukil_a@yahoo.com>
In-Reply-To: <E1E3DJm-0000jy-0B@be1.lrz>
References: <4Ae73-6Mm-5@gated-at.bofh.it>  <E1E3DJm-0000jy-0B@be1.lrz>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 10:05:39 -0400
Message-Id: <1123769139.17269.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 15:41 +0200, Bodo Eggert wrote:
> According to my documentation it isn't. A software interrupt is a far call
> with an extra pushf, and a hardware interrupt is protected against recursion
> by the PIC, not by an interrupt flag.

I disagree with your definition of a system call.  The "int 0x80"
changes from user mode to kernel mode so it is much more powerful than a
"far call".  Also the CPU does protect against recursion and more than
one interrupt coming in at the same time. The PIC also works with the
CPU in this regard, but as I shown in my previous email, the interrupt
flag _does_ protect against it.

-- Steve



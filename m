Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbULNV5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbULNV5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbULNV5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:57:25 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:37539 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261672AbULNVzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:55:31 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andi Kleen <ak@suse.de>
Date: Tue, 14 Dec 2004 23:01:12 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <380350F3EC1@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Dec 04 at 8:45, Andi Kleen wrote:
> > #define TOLM                            \
> >                 "pushl %%cs\n"          \
> >                 "pushl $91f\n"          \
> >                 "ljmpl $0x33,$90f\n"    \
> 
> It's useless, there is nothing in the kernel code that checks the 
> 32bit segment.

???  Processor checks for 32bit/64bit segment.  It is impossible to load
upper 32bit of all registers with non-zero value or call 64bit
syscall entry point from 32bit mode.  As x86-64 kernel offers 64bit 
interface through syscall only, only way how to issue 64bit system call
is using syscall instruction in 64bit code.

Or are you trying to say that these samples do not work and you cannot
call 64bit entry point from 32bit app, or vice versa?  Then I'm afraid
that you are not completely right, as these samples do work...
                                                Petr Vandrovec


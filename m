Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSKMUhx>; Wed, 13 Nov 2002 15:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSKMUhx>; Wed, 13 Nov 2002 15:37:53 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:41386 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262664AbSKMUhw>; Wed, 13 Nov 2002 15:37:52 -0500
Subject: RE: FW: i386 Linux kernel DoS (clarification)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Leif Sawyer <lsawyer@gci.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <76C6E114FA8@vcnet.vc.cvut.cz>
References: <76C6E114FA8@vcnet.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 21:10:14 +0000
Message-Id: <1037221814.12445.126.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 20:36, Petr Vandrovec wrote:
> 2.5.47-current-bk, run as mere user: Kernel panic: Attempted to kill init!
> Next time I'll trust you.

It does the lcall
The lcall takes an exception
The exception (TF) has NT set
iret returns via the task linkage

I think just clearing the NT bit in both lcall path _and_ in the TF
exception handler does the trick.



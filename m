Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030627AbWJCW3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030627AbWJCW3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWJCW3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:29:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31885 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030625AbWJCW3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:29:06 -0400
Subject: Re: =?ISO-8859-1?Q?Registration=A0Weakness=A0?=
	=?ISO-8859-1?Q?in=A0Linux=A0Kernel's=A0Bin?= =?ISO-8859-1?Q?ary=A0formats?=
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chase Venters <chase.venters@clientec.com>
Cc: SHELLCODE Security Research <GoodFellas@shellcode.com.ar>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610031645340.3514@turbotaz.ourhouse>
References: <1159902785.2855.34.camel@goku.staff.locallan>
	 <Pine.LNX.4.64.0610031645340.3514@turbotaz.ourhouse>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2006 23:54:14 +0100
Message-Id: <1159916054.17553.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-03 am 16:48 -0500, ysgrifennodd Chase Venters:
> So the problem you find is that newly registered binfmts are inserted into 
> the front of the binfmt list instead of the rear, and this means that a 
> binfmt handler can slip in at runtime at run quietly before any other 
> handler?

This is a feature as anyone trying to debug versions of the elf loader
could would find out quite fast.

> 
> I'm not sure I see this as a real problem. If you can load a module into 
> kernel space and access arbitrary symbols (not to mention run in ring 0) I 
> think you can do a lot more than just hide out on the binfmt list.
> 
> Am I missing something?

Don't think so. At the point you can load code into the kernel you can
replace any code anyway.

NOTABUG

Alan


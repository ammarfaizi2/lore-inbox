Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVJYUUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVJYUUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVJYUUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:20:15 -0400
Received: from mxsf33.cluster1.charter.net ([209.225.28.158]:42381 "EHLO
	mxsf33.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932341AbVJYUUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:20:13 -0400
X-IronPort-AV: i="3.97,250,1125892800"; 
   d="scan'208"; a="1575427695:sNHT2790150130"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17246.37752.535232.788287@smtp.charter.net>
Date: Tue, 25 Oct 2005 16:20:08 -0400
From: "John Stoffel" <john@stoffel.org>
To: chase.venters@clientec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in do_page_fault
In-Reply-To: <60411.67.163.102.102.1130266824.squirrel@webmail2.pair.com>
References: <60411.67.163.102.102.1130266824.squirrel@webmail2.pair.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


chase> Please forgive me in advanced for the length of this
chase> description - I don't want to leave out any important details.

[ edited down ]

chase> In 2.6.13, I get an Oops (translated by hand, sorry for inexact formatting):

chase> Oops 0000 #1
chase> PREEMPT SMP
chase> (list of modules linked in includes some alsa modules, nvidia.ko and
chase> sk98lin.ko)

chase> CPU 0
chase> EIP 0060:[<c01182c3>] Tainted: P VLI
chase> EFLAGS: 00010086 (2.6.13)
chase> EIP is at do_page_fault+0xa3/0x5db
chase> eax: f5e50000  ebx: 0000000b  ecx: 0000000d  edx: 0000000d
chase> esi: 0000000e  edi: c0567451  ebp: 00000000  esp: f5e5a10c

chase> ds: 007b  es: 007b  ss: 0068

Please remove the binary only nvidia and sklin module(s) you have on
the system so that the kernel isn't tainted any more, and then see if
you can reproduce this problem.  You'll need to not only remove the
module, but then reboot to make sure it comes up cleanly without any
corruption.  We can't help debug your issues if you're using binary
only modules.  Sorry.

John

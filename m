Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269259AbTGUFfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 01:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269266AbTGUFfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 01:35:20 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:35770 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S269259AbTGUFfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 01:35:15 -0400
Message-ID: <0be401c34f4b$e33775b0$64ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
References: <081701c34ed0$5be60070$64ee4ca5@DIAMONDLX60> <200307201526.h6KFQs9K003972@turing-police.cc.vt.edu>
Subject: Re: Tried to run 2.6.0-test1 
Date: Mon, 21 Jul 2003 14:48:59 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again I cannot keep up with the mailing list.  If anyone wishes to advise or
has questions, please kindly contact me directly.

1.  Trying to upgrade modutils.

I've downloaded modutils-2.4.21-18.src.rpm from Rusty Russell's directory on
ftp.kernel.org.  Not being an rpm expert, I tried "rpm --rebuild" on it.
The compilation steps assume -mcpu=i686.  I need to specify that the cpu is
an i586.

"man rpm" and "info rpm" both say that arch-vendor-os can be designated,
but -march=i486 is already fine with me, the problem is the cpu not the
arch.  I'm not sure what it would mean to try specifying a vendor (Intel) or
OS (Linux).  There seems to be no way to specify the cpu in "rpm --rebuild".

I also tried rpm -ivh and finally found where three files got installed to.
Two gzipped tarballs and one spec file.  The spec file doesn't specify the
cpu, as far as I can tell.

Odds are I can probably gunzip and tar and compile the new modutils, but
will the resulting executables get installed into the right places without
using the rpm command and its spec file, I'm not sure I want to chance it.

My .config file for the kernel sources correctly designates the cpu as an
i586mmx, but I guess modutils shouldn't be expected to guess which kernel
sources to find and extract the cpu type from it.

2.  Blank screen during/after boot.

Two people recommended alternative locations for the "post-halloween"
document and I got one.

> Known gotchas.
> Certain known bugs are being reported over and over. Here are the
>     workarounds.
> - Blank screen after decompressing kernel?
>   Make sure your .config has
>   CONFIG_INPUT=y, CONFIG_VT=y, CONFIG_VGA_CONSOLE=y and
>     CONFIG_VT_CONSOLE=y

It has.  The screen is still blank after decompressing the kernel.  In SuSE
8.1 the screen goes completely blank and never recovers.  In Red Hat  the
screen continues displaying the message about decompressing the kernel but
freezes there until X comes up, and then returns to that same frozen text
screen during shutdown, so I have to guess when it's OK to turn off the
power.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbTA0GIt>; Mon, 27 Jan 2003 01:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266318AbTA0GIt>; Mon, 27 Jan 2003 01:08:49 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:10632 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S266285AbTA0GIs>;
	Mon, 27 Jan 2003 01:08:48 -0500
Date: Sun, 26 Jan 2003 22:17:20 -0800
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030127061720.GB13835@vana.vc.cvut.cz>
References: <20030126215714.GA394@kugai> <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301261524570.15900-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 03:46:30PM -0600, Kai Germaschewski wrote:
> 
> o One thing I do not understand at all: What is the problem with using
>   the internal build system? It makes maintainance of external modules
>   much easier than keeping track of what happens in the kernel and
>   patching a private solution all the time.
> 
>   I don't even see any license issues, first of all you don't even 
>   distribute it, the user who's building the module will already have it 
>   along with his kernel source. And if you're using it to compile 
>   (possibly binary) modules you want to distribute, you can just use it 
>   just like gcc without any further obligations, so no problem there
>   either. (IANAL, of course)

>From my exprience at VMware newsgroups distros have bad troubles even
with delivery of basic configured kernel headers matching to kernel
binaries they provide (it is not unusual that for example they go from
1GB to 4GB kernel without make mrproper so kmap/kunmap do not have proper
versions attached :-( or they even sell headers and binaries with
different configs). Trying to ask them to provide usable configured kernel
sources (and not one which automagically replace -3 with -3custom
so that modules built by internal build system do not match to kernel
at all...) is not going to work - it did not work in the past, and I see
no reason why it should start working now. And dialup users do not want to
download 30MB package when 2MB headers were always enough (and especially
if they'll use 1.5MB from the downloaded package to build 3rd party module).

There are few exceptinons of distros which provide kernel sources in
usable form (== without any user intervention /lib/modules/`uname -r`/build
points to working correctly configured kernel tree), but usually their
users build their own kernels anyway, so nobody profits from that :-(

						Petr Vandrovec
						vandrove@vc.cvut.cz

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUJEXIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUJEXIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUJEXIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:08:44 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:56767
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S266555AbUJEXFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:05:31 -0400
Message-ID: <416328AB.1060909@ppp0.net>
Date: Wed, 06 Oct 2004 01:05:15 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.5-1.358 SMP
References: <Pine.LNX.4.53.0410051852250.351@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.53.0410051852250.351@chaos.analogic.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Hello,
> 
> I almost have everything converted over from 2.4.26 to
> 2.6.whatever.
> 
> I need to make some modules that have lots of assembly code.
> This assembly uses the UNIX calling convention and can't be
> re-written (it would take many months). The new kernel
> is compiled with "-mregparam=2". I can't find where that's
> defined. I need to remove it because I cannot pass parameters
> to the assembly stuff in registers.
> 
> Where is it defined??? I grepped through all the scripts and
> the hidden files, but I can't discover where it's defined.

You don't mean CONFIG_REGPARM=n:

arch/i386/Makefile:cflags-$(CONFIG_REGPARM)     += $(shell if [ 
$(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)

?

Jan

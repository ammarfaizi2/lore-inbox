Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUHQJ3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUHQJ3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 05:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUHQJ3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 05:29:54 -0400
Received: from mail.convergence.de ([212.84.236.4]:33187 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264639AbUHQJ3x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 05:29:53 -0400
Date: Tue, 17 Aug 2004 11:30:34 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] HOWTO find oops location, v2
Message-ID: <20040817093034.GA14077@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200408151439.31891.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408151439.31891.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 02:39:31PM +0300, Denis Vlasenko wrote:
> I've got some useful feedback. This is v2 of the HOWTO.
> 
> CFLAGS="-g -Wa,-a,-ad" trick almost, but not quite works.
...
> I tried
> 
> make CFLAGS="-g -Wa,-a,-ad" fs/dcache.o >dcache.asm
> 
> but result was very dirrerent because in this case gcc was run
> without these flags:
> 
> -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
> -fno-common -pipe -msoft-float -mpreferred-stack-boundary=2
> -march=i486 -I/.1/usr/srcdevel/kernel/linux-2.6.7-bk20.src/include/asm-i386/mach-default
> -Iinclude/asm-i386/mach-default -O2 -falign-functions=1 -falign-labels=1 -falign-loops=1
> -falign-jumps=1
> 
> and dcache.asm was useless.

Try: make EXTRA_CFLAGS="-g -Wa,-a,-ad" fs/dcache.o >dcache.asm

Or, what I usually do, "make V=1 fs/dcache.o" and then copy&paste
and edit the commandline manually.

Johannes

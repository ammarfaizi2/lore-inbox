Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbSKCUEr>; Sun, 3 Nov 2002 15:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262374AbSKCUEr>; Sun, 3 Nov 2002 15:04:47 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:30993 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262372AbSKCUEq>; Sun, 3 Nov 2002 15:04:46 -0500
Date: Sun, 3 Nov 2002 21:10:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5: troubles with piping make output
In-Reply-To: <200211031946.gA3JkIp29186@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0211032106010.6949-100000@serv>
References: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua>
 <20021103182805.GA1057@mars.ravnborg.org> <200211031946.gA3JkIp29186@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002, Denis Vlasenko wrote:

> *
> * Processor type and features
> *
> Processor family (386, 486, 586/K5/5x86/6x86/6x86MX, Pentium-Classic, Pentium-MMX, Pentium-Pro/Celeron/Pentium-II, Pentium-III/Celeron(Coppermine), Pentium-4, K6/K6-II/K6-III, Athlon/Duron/K7, Elan, Crusoe, Winchip-C6, Winchip-2, Winchip-2A/Winchip-3, CyrixIII/VIA-C3) [386] (NEW)
> 
> and it politely waits for my input.
> 
> Looks like fflush() got forgotten somewhere ;)

What shell are you using?
This is what should happen:

$ make 2>&1 | tee
make[1]: `scripts/kconfig/conf' is up to date.
./scripts/kconfig/conf -s arch/i386/Kconfig
#
# using defaults found in .config
#
*
* Restart config...
*
*
* Processor type and features
*
Processor family (386, 486, 586/K5/5x86/6x86/6x86MX, Pentium-Classic, Pentium-MMX, Pentium-Pro/Celeron/Pentium-II, Pentium-III/Celeron(Coppermine), Pentium-4, K6/K6-II/K6-III, Athlon/Duron/K7, Elan, Crusoe, Winchip-C6, Winchip-2, Winchip-2A/Winchip-3, CyrixIII/VIA-C3) [Pentium-Pro/Celeron/Pentium-II] (NEW) aborted!

Console input/output is redirected. Run 'make oldconfig' to update configuration.

make: *** [include/linux/autoconf.h] Error 1

bye, Roman



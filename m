Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbSLEKGG>; Thu, 5 Dec 2002 05:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbSLEKGG>; Thu, 5 Dec 2002 05:06:06 -0500
Received: from turn6.biologie.uni-konstanz.de ([134.34.128.74]:4249 "EHLO
	turn6.biologie.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S267263AbSLEKGF>; Thu, 5 Dec 2002 05:06:05 -0500
Message-ID: <3DEF26D3.7A4236D7@uni-konstanz.de>
Date: Thu, 05 Dec 2002 11:13:39 +0100
From: Kay Diederichs <kay.diederichs@uni-konstanz.de>
Organization: =?iso-8859-1?Q?Universit=E4t?= Konstanz
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-mosix i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: stock 2.4.20: loading amd76x_pm makes time jiggle on A7M266-D
References: <3DEDF543.51C80677@uni-konstanz.de> <1039009531.15353.13.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Wed, 2002-12-04 at 12:29, Kay Diederichs wrote:
> > the subject says it all:
> >
> > if I use the powersaving module amd76x_pm then the time is not kept. The
> > hardware is Asus A7M266-D with 2 MP1900 processors, BIOS is 1004 (but I
> > tried later BIOS versions as well).
> 
> Boot with "notsc". Unfortunately I dont think there is a way I can make
> the module turn off tsc at runtime.

To use "notsc" I had to set CONFIG_X86_TSC_DISABLE=y , but then init
fails (booting stops after freeing some kernel memory). Configure.help
says one has to install a TSC-checking glibc if that happens; I 
installed the latest glibc-2.2.4-31 from redhat/7.2/updates but still
init fails. Are there RH7.2 compatible versions of glibc which are
TSC-checking?

I also tried 
echo 01 >/proc/irq/0/smp_affinity
and it seems to improve the situation but I'm not sure if this is a good
workaround.

Kay
-- 
Kay Diederichs         http://strucbio.biologie.uni-konstanz.de/~kay 
email: Kay.Diederichs @ uni-konstanz.de  Tel +49 7531 88 4049 Fax 3183
When replying to my email, please remove the blanks before and after the
"@" !
Fakultaet fuer Biologie, Universitaet Konstanz, Box M656, D-78457
Konstanz

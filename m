Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbSKUH6f>; Thu, 21 Nov 2002 02:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266390AbSKUH6e>; Thu, 21 Nov 2002 02:58:34 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12808 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S266384AbSKUH6e>; Thu, 21 Nov 2002 02:58:34 -0500
Message-Id: <200211210759.gAL7xhp24333@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Mark H. Wood" <mwood@IUPUI.Edu>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: One more time:  /usr/include/linux, /usr/include/asm
Date: Thu, 21 Nov 2002 10:50:36 -0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.33.0211201643180.359-100000@mhw.ULib.IUPUI.Edu>
In-Reply-To: <Pine.LNX.4.33.0211201643180.359-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 November 2002 20:05, Mark H. Wood wrote:
> I just built a new glibc.  (Yes, I do that.)  Recalling that the
> above-mentioned paths are (according to Linus and many others) not
> supposed to be links to /usr/src/linux or any other
> kernel-kit-du-jour, I resolved to be a good boy and get rid of those
> links.  For some reason I expected that 'make install' for glibc
> would create directories there and put into them whatever it wanted. 
> I recall that that was discussed....
>
> No dice.  glibc 2.3.1 still installs headers into
> /usr/include/{VARIOUS} which refer to /usr/include/linux and
> /usr/include/asm but does not supply that to which they refer. 
> *sigh*  After rummaging through several long threads in the archives,
> I still don't have an answer to the following:
>
> 1. What is supposed to be in /usr/include/linux and /usr/include/asm?

Kernel header files against which glibc was built.

> 2. Where does the information come from?

>From kernel source you chose to build glibc against.
There is a glibc configure option to select which kernel
header directory to use. I normally copy it from latest
stable kernel into glibc source to prevent any unwanted
interactions.

> 3. Who is responsible for putting it there?

Don't remember. Anyway, it's easy to do by hand if make install
did not do it for you.
--
vda

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVJDPKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVJDPKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVJDPKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:10:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36300 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964795AbVJDPKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:10:13 -0400
Date: Tue, 4 Oct 2005 08:09:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
cc: Ryan Anderson <ryan@autoweb.net>, Luben Tuikov <luben_tuikov@adaptec.com>,
       andrew.patterson@hp.com, Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <Pine.BSO.4.62.0510041438100.28198@rudy.mif.pg.gda.pl>
Message-ID: <Pine.LNX.4.64.0510040803010.31407@g5.osdl.org>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
  <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>
  <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>
  <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com> 
 <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>  <4341381D.2060807@adaptec.com>
  <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl> 
 <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com> 
 <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl>
 <1128377075.23932.5.camel@ryan2.internal.autoweb.net>
 <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org>
 <Pine.BSO.4.62.0510041438100.28198@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1805352014-1128438578=:31407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1805352014-1128438578=:31407
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 4 Oct 2005, Tomasz K³oczko wrote:
>
> On Mon, 3 Oct 2005, Linus Torvalds wrote:
> [..]
> > This is especially common in the "cheap" market. For example, for SCSI,
> > most of the violations tend to be USB storage - which is supposed to act
> > largely like SCSI, but in reality really doesn't. It locks up if you
> > try to access sectors that aren't there, etc.
> 
> Yes .. of course .. but please don't tap some words (without this kind
> comment) which sounds like rules [1]. *Especialy if* talk is about *one*
> specified piece of hardware.

What "one" piece of hardware? There's a hell of a lot more broken USB 
devices out there (and no, it's not "one" type either) than there will 
probably _ever_ be SAS devices.

And the thing is, from a kernel _maintenance_ standpoint, the broken 
hardware is the one that is expensive. Maybe only 0.1% of all hardware 
ends up having some bugs - but that doesn't matter. It may look like a 
"small" percentage to you, but it ends up being a _huge_ burden on 
developers to try to figure out what is going on, often _exactly_ because 
it's a small percentage, and the developers don't have it.

So the argument that "most hardware conforms to spec" is not a valid 
argument. Not if it's 51%, and not if it's 99.9%. Because the cost is in 
the ones that don't.

And that is why I'm trying to educate people that specs are purely paper. 
Often much less valuable than a roll of TP. 

Because what matters is not the spec, but real life. For example, in the 
SCSI layer we've ended up being much more successful with the approach of 
trying to use the same discovery sequence as Windows - because unlike the 
spec, that's REAL LIFE, and that's the case that actually works.

The same way software inevitably has bugs in areas that haven't been 
tested, hardware has bugs in areas that haven't been tested. It has 
nothing to do with specs, and no, specs don't make people test it.

			Linus
--21872808-1805352014-1128438578=:31407--

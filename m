Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbUBKTl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbUBKTl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:41:28 -0500
Received: from hera.kernel.org ([63.209.29.2]:51615 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265719AbUBKTlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:41:22 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: printk and long long
Date: Wed, 11 Feb 2004 19:41:15 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0e0gr$mcv$1@terminus.zytor.com>
References: <200402111604.49082.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0402111655170.17933-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076528475 22944 63.209.29.3 (11 Feb 2004 19:41:15 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 11 Feb 2004 19:41:15 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0402111655170.17933-100000@gaia.cela.pl>
By author:    Maciej Zenczykowski <maze@cela.pl>
In newsgroup: linux.dev.kernel
>
> On Wed, 11 Feb 2004, vda wrote:
> 
> > The character L specifying that a following e, E, f, g, or G
> > conversion corresponds to a long double argument, or a following
> > d, i, o, u, x, or X conversion corresponds to a long long argument.
> > Note that long long is not specified in ANSI C and therefore
> > not portable to all architectures.
> 
> [ personally I'd say screw the un-portable architectures ;) ]
> Long long is here to stay.

long long is C99, so it's *definitely* here to say.  The conversion specifier
is "ll" not "L", however.

> Besides if a linux architecture utilises long long in the kernel and 
> doesn't support it in printf via %lld then it's horked.
> printf/libc should be fixed instead.
> Maybe that's the problem - the libc support fragment in the kernel tree is 
> not up to date on that architecture - maybe the fixes should applied there 
> instead - instead of trying to work around the problem, fix the cause.

Indeed.  Feel free to steal the code from klibc :)

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUCIAaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUCIAaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:30:20 -0500
Received: from hera.kernel.org ([63.209.29.2]:61841 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261220AbUCIAaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:30:15 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] UTF-8ifying the kernel source
Date: Tue, 9 Mar 2004 00:30:05 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c2j36d$2ej$1@terminus.zytor.com>
References: <20040304100503.GA13970@havoc.gtf.org> <20040305232425.GA6239@havoc.gtf.org> <c2b2o0$cbp$1@terminus.zytor.com> <1078571331.963.3.camel@bip.parateam.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1078792205 2516 63.209.29.3 (9 Mar 2004 00:30:05 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 9 Mar 2004 00:30:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1078571331.963.3.camel@bip.parateam.prv>
By author:    Xavier Bestel <xavier.bestel@free.fr>
In newsgroup: linux.dev.kernel
>
> Le sam 06/03/2004 à 00:33, H. Peter Anvin a écrit :
> > Followup to:  <20040305232425.GA6239@havoc.gtf.org>
> > By author:    David Eger <eger@havoc.gtf.org>
> > In newsgroup: linux.dev.kernel
> > 
> > > The third patch concerns 8-bit characters embedded in C strings.
> > > These are almost always output to devfs or proc.  The characters used are
> > > the degrees symbol (for ppc temp. sensors) and mu (for micro-seconds).
> >
> > I would highly vote for making those UTF-8 unless it breaks protocol.
> 
> ISO-8859-1 characters are mostly the same in UTF-8.
> 

Unicode, yes.  UTF-8, no.  The ISO-8859-1 character "Å" (0xC5) does,
indeed correspond to Unicode character U+00C5, but it's encoded 0xC3
0x85 in UTF-8.

	-hpa

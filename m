Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWAXJTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWAXJTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWAXJTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:19:52 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:62142 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030420AbWAXJTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:19:52 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 24 Jan 2006 10:18:31 +0100
To: schilling@fokus.fraunhofer.de, arjan@infradead.org
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <43D5F0E7.nailCEZ11QJYW@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner>
 <20060123203010.GB1820@merlin.emma.line.org>
 <1138092761.2977.32.camel@laptopd505.fenrus.org>
 <43D5EEA2.nailCE7111GPO@burner>
 <1138094141.2977.34.camel@laptopd505.fenrus.org>
In-Reply-To: <1138094141.2977.34.camel@laptopd505.fenrus.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:

> On Tue, 2006-01-24 at 10:08 +0100, Joerg Schilling wrote:
> > > the situation is messy; I can see some value in the hack Ted proposed to
> > > just bump the rlimit automatically at an mlockall-done-by-root.. but to
> > > be fair it's a hack :(
> > 
> > As all other rlimits are honored even if you are root, it looks not orthogonal 
> > to disregard an existing RLIMIT_MEMLOCK rlimit if you are root.
>
> that's another solution; give root a higher rlimit by default for this.
> It's also a bit messy, but a not-unreasonable default behavior.

This would only make sense in case that you bump up the limit for processes
that are suid root and do not lower it in case someone calls seteuid().

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

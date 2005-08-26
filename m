Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVHZIfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVHZIfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 04:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVHZIfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 04:35:04 -0400
Received: from ns.firmix.at ([62.141.48.66]:45516 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750834AbVHZIfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 04:35:02 -0400
Subject: Re: A Great Idea (tm) about reimplementing NLS.
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Daniel B." <dsb@smart.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <430E5B8E.5C89A06B@smart.net>
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <f192987705061310202e2d9309@mail.gmail.com>
	 <1118690448.13770.12.camel@localhost.localdomain>
	 <200506152149.06367.pmcfarland@downeast.net>
	 <20050616023630.GC9773@thunk.org> <87y89a7wfn.fsf@jbms.ath.cx>
	 <20050616143727.GC10969@thunk.org>  <20050619175503.GA3193@elf.ucw.cz>
	 <1119292723.3279.0.camel@localhost.localdomain>
	 <430E5B8E.5C89A06B@smart.net>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Fri, 26 Aug 2005 10:34:54 +0200
Message-Id: <1125045294.7282.12.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 20:00 -0400, Daniel B. wrote:
> Alan Cox wrote:
> > On Sul, 2005-06-19 at 18:55, Pavel Machek wrote:
[...]
> > > If we are serious about utf-8 support in ext3, we should return
> > > -EINVAL if someone passes non-canonical utf-8 string.
> > 
> > That would ironically not be standards compliant
> 
> Which standards?

Probably POSIX, SuSv3 and similiar.

> The standards I've read (mostly XML- and web-related specs)
> do say that non-standard UTF-8 octet sequences should be rejected.

There you have basically text files with some structure in it and the
definiton/requirement that is is UTF-8.
At kernel level these are also just byte streams and the kernel doesn't
know or care which charset, encoding, file format, font etc. the data is
used with or interpreted several layers higher, e.g. for presenting to
the user. And the same holds for filenames.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


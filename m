Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932794AbWF1Ngi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794AbWF1Ngi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 09:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWF1Ngi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 09:36:38 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:42137 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S932794AbWF1Ngh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 09:36:37 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: oom-killer problem
Date: Wed, 28 Jun 2006 15:37:34 +0200
User-Agent: KMail/1.7.2
Cc: Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <5920.1151458933@kao2.melbourne.sgi.com>
In-Reply-To: <5920.1151458933@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606281537.35203.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-05.tornado.cablecom.ch 1378;
	Body=5 Fuz1=5 Fuz2=5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 June 2006 03.42, Keith Owens wrote:
> Linus Torvalds (on Tue, 27 Jun 2006 18:15:46 -0700 (PDT)) wrote:
> >
> >
> >On Tue, 27 Jun 2006, Daniel Ritz wrote:
> >>  
> >>  # Default for not multi-part modules
> >> -modname = $(basetarget)
> >> +modname = $(basename $(basetarget))
> >
> >Is there some way to make it clear _what_ the suffix we expect to remove 
> >actually is in GNU make? Ie the "shell" kind of "basename" logic.
> >
> >Ie, I'd personally be happier with a 
> >
> >	modname = $(basename $(basetarget) .mod)
> >
> >kind of thing (yeah, this obviously does _not_ work)
> 
> modname = $(patsubst %.mod,%,$(basetarget))
> 
> should do it (untested).
> 

yep, works fine.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbWI1OWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWI1OWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWI1OWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:22:49 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:17774 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161147AbWI1OWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:22:48 -0400
Date: Thu, 28 Sep 2006 16:21:39 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       holzheu@de.ibm.com
Subject: Re: [S390] hypfs sparse warnings.
Message-ID: <20060928142139.GC6899@osiris.boeblingen.de.ibm.com>
References: <20060928130737.GB1120@skybase> <20060928132540.GA18933@wohnheim.fh-wedel.de> <20060928134247.GB6899@osiris.boeblingen.de.ibm.com> <20060928135406.GB18933@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928135406.GB18933@wohnheim.fh-wedel.de>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 03:54:06PM +0200, J?rn Engel wrote:
> On Thu, 28 September 2006 15:42:47 +0200, Heiko Carstens wrote:
> > On Thu, Sep 28, 2006 at 03:25:40PM +0200, J?rn Engel wrote:
> > > On Thu, 28 September 2006 15:07:37 +0200, Martin Schwidefsky wrote:
> > > > 
> > > > sparse complains, if we use bitwise operations on enums. Cast enum to
> > > > long in order to fix that problem!
> > > 
> > > At this point I start to wonder which part should be changed.  Is it
> > > better to
> > > a) cast some more, as you started to do,
> > > b) change enums to #defines or
> > > c) change '|' to '+'?
> > > 
> > > At any rate, you have the same problem in 5 seperate places by my
> > > count and only changed 1 of them.  Nak - in case anyone cares.
> > 
> > That would be where? My sparse run didn't reveal anything else.
> 
> Search for diag204.  All calls have the same format with bitwise or of
> two enums, so they are all equally (in-)correct.

You probably need to update your git tree. All of them have casts in the
meantime. Except for the one addressed with this patch.
See: 331c982d4a6b43cdc0d056956a1cae8a7d6237bf

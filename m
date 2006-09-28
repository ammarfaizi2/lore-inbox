Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161131AbWI1NyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161131AbWI1NyK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWI1NyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:54:09 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:12454 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1161131AbWI1NyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:54:07 -0400
Date: Thu, 28 Sep 2006 15:54:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       holzheu@de.ibm.com
Subject: Re: [S390] hypfs sparse warnings.
Message-ID: <20060928135406.GB18933@wohnheim.fh-wedel.de>
References: <20060928130737.GB1120@skybase> <20060928132540.GA18933@wohnheim.fh-wedel.de> <20060928134247.GB6899@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060928134247.GB6899@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 September 2006 15:42:47 +0200, Heiko Carstens wrote:
> On Thu, Sep 28, 2006 at 03:25:40PM +0200, J?rn Engel wrote:
> > On Thu, 28 September 2006 15:07:37 +0200, Martin Schwidefsky wrote:
> > > 
> > > sparse complains, if we use bitwise operations on enums. Cast enum to
> > > long in order to fix that problem!
> > 
> > At this point I start to wonder which part should be changed.  Is it
> > better to
> > a) cast some more, as you started to do,
> > b) change enums to #defines or
> > c) change '|' to '+'?
> > 
> > At any rate, you have the same problem in 5 seperate places by my
> > count and only changed 1 of them.  Nak - in case anyone cares.
> 
> That would be where? My sparse run didn't reveal anything else.

Search for diag204.  All calls have the same format with bitwise or of
two enums, so they are all equally (in-)correct.

Jörn

-- 
Prosperity makes friends, adversity tries them.
-- Publilius Syrus

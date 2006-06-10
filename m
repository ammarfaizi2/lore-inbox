Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWFJAHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWFJAHi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWFJAHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:07:38 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:46092 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932333AbWFJAHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:07:37 -0400
Date: Sat, 10 Jun 2006 02:07:34 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610000734.GA56336@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4489A7ED.8070007@garzik.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 12:55:09PM -0400, Jeff Garzik wrote:
> Alex Tomas wrote:
> >so, instead of taking one (quite-well-tested) part that solves one of
> >the biggest ext3 limitation, you propose to start a new project and
> >get something in a year (probably) ?
> >
> >I think about extents as a step-by-step way ...
> 
> That is what the entirety of Linux development is -- step-by-step.
> 
> It is OBVIOUS that it would take five minutes to start ext4.
> 
> 1) clone a new tree
> 2) cp -a fs/ext3 fs/ext4
> 3) apply extent and 48bit patches
> 4) apply related e2fsprogs patches

5) force all options (attributes, etc) on and remove the flags
   indicating their existence from the metadata, you'll need the space
   for the fs evolution.

6) change the fs just enough so that an ext4 fs can never be mounted
   as ext3 or 2.

  OG.

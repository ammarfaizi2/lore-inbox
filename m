Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUBKGj0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 01:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUBKGj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 01:39:26 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:38408 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S263510AbUBKGjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 01:39:25 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1076481367@astro.swin.edu.au>
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
In-reply-to: <20040209115852.GB877@schottelius.org>
References: <20040209115852.GB877@schottelius.org>
X-Face: "/6m>=uJ8[yh+S{nuW'%UG"H-:QZ$'XRk^sOJ/XE{d/7^|mGK<-"*e>]JDh/b[aqj)MSsV`X1*pA~Uk8C:el[*2TT]O/eVz!(BQ8fp9aZ&RM=Ym&8@.dGBW}KDT]MtT"<e(`rn*-w$3tF&:%]KHf"{~`X*i]=gqAi,ScRRkbv&U;7Aw4WvC
X-Face-Author: David Bonde mailto:i97_bed@i.kth.se.REMOVE.THIS.TO.REPLY -- If you want to use it please also use this Authorline.
Message-ID: <slrn-0.9.7.4-32556-23428-200402111736-tc@hexane.ssi.swin.edu.au>
Date: Wed, 11 Feb 2004 17:39:15 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius <nico-kernel@schottelius.org> said on Mon, 9 Feb 2004 12:58:52 +0100:
> 
> --GRPZ8SYKNexpdSJ7
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> Morning!
> 
> What Linux supported filesystems support UTF-8 filenames?
> 
> Looks like at least xfs and reiserfs are not able of handling them,
> as Apache with UTF-8 as default charset delievers wrong names, when
> accessing files with German umlauts.

I submitted a bug to the jfs people, because jfs incorrectly returns
-EINVAL (this isn't even documented in man pages as a valid return
from open()) from an open() on a filename with UTF-8 in it.

See http://www-124.ibm.com/developerworks/bugs/?func=detailbug&bug_id=3838&group_id=35
and http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=229308

This was triggered just by upgrading the console-utils package in
debian (the problem existed all along, except that when I first made
the filesystem a jfs one, I reinstalled from backups, rather than
reinstalling debian from scratch)

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Just don't create a file called -rf.  :-)
        -- Larry Wall in <11393@jpl-devvax.JPL.NASA.GOV>

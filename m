Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVBOH7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVBOH7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 02:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVBOH7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 02:59:24 -0500
Received: from dsl027-162-124.atl1.dsl.speakeasy.net ([216.27.162.124]:61879
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S261646AbVBOH7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 02:59:22 -0500
Date: Tue, 15 Feb 2005 02:45:39 -0500
From: Sonny Rao <sonny@burdell.org>
To: Alex Tomas <alex@clusterfs.com>
Cc: Mingming Cao <cmm@us.ibm.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>, tytso@mit.edu, pbadari@us.ibm.com,
       suparna@in.ibm.com, gerrit@us.ibm.com, tappro@clusterfs.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Latest ext3 patches (extents, mballoc, delayed allocation)
Message-ID: <20050215074539.GA12576@kevlar.burdell.org>
References: <1106354192.3634.19.camel@dyn318043bld.beaverton.ibm.com> <m3hdl2lehb.fsf@bzzz.home.net> <4207BBEA.7090705@us.ibm.com> <m3y8dude4q.fsf@bzzz.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3y8dude4q.fsf@bzzz.home.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 11:40:21PM +0300, Alex Tomas wrote:
> 
> Good day all, 
> 
> I've updated the patchset against 2.6.10. A bunch of bugs have been
> fixed and mballoc now behaves smarter a bit. Extents and mballoc 
> patches collects some stats they print upon umount. NOTE: they must
> not be used to store important data. A lot of things are to be done.
> 
> Please review. Any comments and suggestions are very welcome.

Alex, small buglet, If the FIBMAP-ioctl get's called on a file with
delayed allocation, you need to flush it (or at least allocate) before
returning the mappings.   This doesn't seem to work properly at
present.  

Sonny
 

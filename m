Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTLECDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 21:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbTLECDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 21:03:25 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:35727 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263638AbTLECDW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 21:03:22 -0500
Date: Thu, 4 Dec 2003 18:03:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andy Isaacson <adi@hexapodia.org>, Rob Landley <rob@landley.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031205020312.GJ29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Szakacsits Szabolcs <szaka@sienet.hu>,
	Andy Isaacson <adi@hexapodia.org>, Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200312041432.23907.rob@landley.net> <20031204172348.A14054@hexapodia.org> <Pine.LNX.4.58.0312050130130.2330@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312050130130.2330@ua178d119.elisa.omakaista.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 01:42:13AM +0200, Szakacsits Szabolcs wrote:
> 
> On Thu, 4 Dec 2003, Andy Isaacson wrote:
> 
> > I'm curious -- does NTFS implement sparse files?  
> 
> Since Win2000 (NTFS 3.0+). Also many recently discussed features like
> file/directory/volume level compression/encryption, undelete, power of 2
> block sizes between 512-64kB, etc.

That gives us some possibilities for 2.7:
 o undelete
 
 Ext2 has undelete support, but that information is overwritten on unlink by
 ext3, so  ext3 won't work with the undelete utilities.  How do the other 
 filesystems fare in this regard?
 
 o per file compression
 
 Ext2/3 has a flag for it, but support hasn't been implemented.
 
 o per file encryption (can use a user space helper for policy)
 
 Reiser4 plans to have a plugin that will support this.
 What about the others?
 
 o make hole support
 
And my personal favorite:
 o pagecache coherent defrag (on live filesystems)
 
Andrew Morton wrote a patch for this a while back but since there were no
userspace utilities, and it was ext3 specific, it wasn't merged, and nothing
AFAIK has happened with it since.

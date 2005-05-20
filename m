Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVETUDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVETUDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVETUDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:03:39 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:55254 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261562AbVETUDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:03:35 -0400
Date: Fri, 20 May 2005 16:03:34 -0400
To: Adam Miller <amiller@gravity.phys.uwm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software RAID
Message-ID: <20050520200334.GF23621@csclub.uwaterloo.ca>
References: <Pine.LNX.4.62.0505201246520.13530@gannon.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505201246520.13530@gannon.phys.uwm.edu>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 12:56:13PM -0500, Adam Miller wrote:
>   We're looking to set up either software RAID 1 or RAID 10 using 2 SATA 
> disks.  If a disk in drive A has a bad sector, can it be setup so that the 
> array will read the sector from drive B and then have it rewrite the 
> bad sector on drive A?  Please CC me in the response.

If a harddisk has a bad sector that is visible to the user (and hence
not remapped by the drive) then it is time to retire the drive since it
is out of spares and very damaged by that point.

If you have a bad sector, it doesn't go away by writing to it again.  On
modern drives, if you see bad sectors the disk is just about dead, and
will probably be seen as such by the raid system which will then stop
using the disk entirely and expect you to replace it ASAP.

Len Sorensen

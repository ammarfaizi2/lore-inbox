Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVHSJjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVHSJjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 05:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVHSJjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 05:39:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35805 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964809AbVHSJjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 05:39:53 -0400
Date: Fri, 19 Aug 2005 10:39:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Mukund JB`." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Fix to Linux FAT12 mount issue?
Message-ID: <20050819093951.GB28917@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Mukund JB`." <mukundjb@esntechnologies.co.in>,
	linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
References: <3AEC1E10243A314391FE9C01CD65429B38E4@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B38E4@mail.esn.co.in>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 02:23:11PM +0530, Mukund JB`. wrote:
> Dear all,
> 
> Its time that there should be a fix applied to the FAT12 subsystem in
> Linux.
> I have noted that removable device FAT12 formatted in Camera like
> digital media does NOT have the FAT12 in sector 0 instead it has a
> partition table that speaks about the FAT12 fs start sector.
> 
> Such devices that do NOT have the file system in sector 0 instead have
> the partition table are failing to mount under Linux.
> Why is it so?
> 
> I have even tested USB mounted device suspecting the in-built
> card-reader driver I am using?
> 
> Even it fails.
> Who has to handle this? which layer?

The user.  If there's a partition table linux will parse it and create
partitions.  You'll have to mount the device node for the partition then.

That's totally standard behaviour as for any other block device.

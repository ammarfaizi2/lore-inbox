Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263043AbVHEOZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbVHEOZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVHEOZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:25:39 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:9934 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262505AbVHEOZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:25:20 -0400
Subject: Re: Symbios problems in recent -mm trees?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050804233927.2d3abb16.akpm@osdl.org>
References: <135040000.1123216397@[10.10.2.4]>
	 <20050804233927.2d3abb16.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 09:24:52 -0500
Message-Id: <1123251892.5003.6.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 23:39 -0700, Andrew Morton wrote:
> James, could some of the scsi core rework have caused this?

Well, I don't think so.  The error below:

> > sdc: Unit Not Ready, sense:
> > : Current: sense key=0x0
> >     ASC=0x0 ASCQ=0x0
> >  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> > Device  not ready.
> >  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> > Device  not ready.
> >  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> > Device  not ready.
> > sdc : READ CAPACITY failed.
> > sdc : status=1, message=00, host=0, driver=08 
> > sd: Current: sense key=0x0
> >     ASC=0x0 ASCQ=0x0

Is coming from the disk not the symbios driver ... I think you have a
disk failure.

James



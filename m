Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266090AbUALJJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 04:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266094AbUALJJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 04:09:50 -0500
Received: from fmr05.intel.com ([134.134.136.6]:53670 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266090AbUALJJm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 04:09:42 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: removable media revalidation - udev vs. devfs or static /dev
Date: Mon, 12 Jan 2004 17:09:35 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8402D4EED7@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: removable media revalidation - udev vs. devfs or static /dev
Thread-Index: AcPWYhFjgmNie2tFQuGkoWRjzBNGOACiA8Rg
From: "Ling, Xiaofeng" <xiaofeng.ling@intel.com>
To: "Joel Becker" <Joel.Becker@oracle.com>, "Greg KH" <greg@kroah.com>
Cc: <linux-hotplug-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Jan 2004 09:09:36.0318 (UTC) FILETIME=[CCE80DE0:01C3D8EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Jan 07, 2004 at 10:57:00AM -0800, Greg KH wrote:
 to create  16 partitions for every block device, if they need them or not.
> 
> 	Um, adding all 16 partitions for a block device that 
> has 5 defined is opposite of the intention of udev, no?  
> While I'd prefer the partition code in-kernel provide hotplug 
> events for each partition, if it is instead scanned by udev, 
> udev should indeed scan the partition table.  Remember, udev 
> should be able to give the appropriate system-defined names 
> for the partition, not just 'sda1'.
> 
> Joel
  I think current kernel do provide hotplug events for each partition, the
key problem is as Linus said, the most hardware will not give a event when
media changes.  So I just use a stupid way(just like "use a big button"),
pull out first and then plug in the flashdriver when changing the media 
or inserting a media to an empty driver. Then udev can remove the old 
node for and create new node for new media. 

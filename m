Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTKHRuJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTKHRuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:50:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24708 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261928AbTKHRuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:50:05 -0500
Message-ID: <3FAD2CB6.5070508@pobox.com>
Date: Sat, 08 Nov 2003 12:49:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
CC: LKML <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@redhat.com>
Subject: Re: libata testing on new machine with ICH5 and PDC20318
References: <3FACC17C.7070901@backtobasicsmgmt.com>
In-Reply-To: <3FACC17C.7070901@backtobasicsmgmt.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:
> I'm building a new server to go into a colo facility in about six weeks; 
> the machine will have an Intel motherboard with an ICH5R (although I 
> won't use the RAID features) and a Promise SATA150 TX4 (no RAID 
> support). All six SATA ports will have Seagate 160GB Barracuda drives 
> attached, and I plan on using software RAID-5 and LVM2 on top of the array.
> 
> I will be building the system using 2.6.0-test9, so will be using libata 
> to drive the disks. If there's anything I can help with 
> debugging/testing the ICH and/or Promise SATA drivers let me know... I 
> see that recently Jeff posted a small patch for some SATA reset issues 
> against -test9, so I'll certainly start out with that included.


The ICH5 should be fine.  You may need to twiddle BIOS setup options, 
some users have reported that both drivers/ide and libata fail in 
certain BIOS modes.  "Enhanced - SATA only" is usually the preferred 
mode, where feasible.

You need to make sure you get the Promise SATA fixes I just pushed to 
Linus.  Presumably they will be available in the next 2.6.0-testX BK 
snapshot on ftp.kernel.org, tonight or the next night.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbTKMT5K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 14:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264413AbTKMT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 14:57:10 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:14977 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264410AbTKMT5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 14:57:08 -0500
Date: Fri, 14 Nov 2003 01:25:26 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Greg KH <greg@kroah.com>, Christian Borntraeger <CBORNTRA@de.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/5] Backing Store for sysfs (Overhauled)
Message-ID: <20031113195526.GD1773@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20031112122344.GD14580@in.ibm.com> <Pine.LNX.4.44.0311131127170.11822-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311131127170.11822-100000@cherise>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 11:34:04AM -0800, Patrick Mochel wrote:
> 
> I still think that keeping the directories static and only creating the 
> leaf (file) dentries dynamically is the best tradeoff between complexity 
> and memory consumption. 

Sounds like after the locking in the current patches fixed, this
should perhaps be implemented and compared for locking complexity
and memory consumption.

> 
> It will require some minor infrastructural modification to associate a
> kobject with all of its leaf nodes, but the result will be cleaner, and
> the worst-case memory consumption will be less than your patches with a 
> per-attribute-per-kobject data structure (which there currently isn't).

Would a smaller replacement for the sysfs_dirent structure to link
just leaf nodes to kobject be close to what infrastructural
modifications you are talking about ?

Thanks
Dipankar

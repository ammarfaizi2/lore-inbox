Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbUBKJcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 04:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUBKJcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 04:32:13 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:4754 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263861AbUBKJcJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 04:32:09 -0500
Date: Wed, 11 Feb 2004 15:06:22 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040211093622.GB9457@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca> <40293508.1040803@nortelnetworks.com> <40293AF8.1080603@backtobasicsmgmt.com> <20040210203900.GA18263@ti19.telemetry-investments.com> <20040211011559.GA2153@kroah.com> <4029883C.2070705@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4029883C.2070705@backtobasicsmgmt.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 01:59:39AM +0000, Kevin P. Fleming wrote:
> Greg KH wrote:
> 
> >Doesn't work for what we want here:
> >
> >	$ mkdir /tmp/a /tmp/b
> >	$ mount -t ramfs none /tmp/a
> >	$ touch /tmp/a/foo
> >	$ mount --move /tmp/a /tmp/b
> >	$ ls /tmp/b
> >	foo
> >	$ umount /tmp/a
> >	$ ls /tmp/b
> >	$ 
> 
> That seems very odd, the "umount /tmp/a" should have failed, given than 
> nothing is mounted there any longer.

I think there is a bug in the mount utility. /etc/mtab is not updated
correctly after "mount --move". /proc/mounts does get updated correctly.
So, if one creates /etc/mtab as sym linked with /proc/mounts, the above 
steps will correctly _fail_ "umount /tmp/a"

Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-5268553
T/L : 9243696

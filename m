Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbSKHHQm>; Fri, 8 Nov 2002 02:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266766AbSKHHQm>; Fri, 8 Nov 2002 02:16:42 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53253 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266765AbSKHHQm>;
	Fri, 8 Nov 2002 02:16:42 -0500
Date: Thu, 7 Nov 2002 23:19:02 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.46: duplicate statistics being gathered
Message-ID: <20021108071901.GB2152@kroah.com>
References: <200211080208.gA828nD24150@eng4.beaverton.ibm.com> <3DCB4B2C.989AA22@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DCB4B2C.989AA22@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 09:27:08PM -0800, Andrew Morton wrote:
> 
> The <unknown quantity of> applications out there which are reading
> the disk info from /proc/stat need to be taught to go fishing in
> /name-of-the-day-fs.
> 
> And that's hard.  /driverfs? /sys? /sysfs? /kernfs?  AFAIK we don't
> even have a recommended mountpoint for the thing, do we?  One way
> to resolve that is for the monitoring application to locate the
> mountpoint by consulting /proc/mounts on startup.

It's now called sysfs and should be mounted at /sys.  I do not think the
name will change anymore (famous last words...)

Unless you want to be different and mount it somewhere else :)

And yes, any application relying on data within it, should be able to
determine its location (through /proc/mounts, or some other such
format.)

thanks,

greg k-h

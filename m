Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSGLXLf>; Fri, 12 Jul 2002 19:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSGLXLe>; Fri, 12 Jul 2002 19:11:34 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:41992 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316788AbSGLXLd>;
	Fri, 12 Jul 2002 19:11:33 -0400
Date: Fri, 12 Jul 2002 16:14:06 -0700
From: Greg KH <greg@kroah.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: Compile warning in fs/partitions/check.c
Message-ID: <20020712231406.GB11995@kroah.com>
References: <Pine.LNX.4.44.0207121640180.3421-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0207121704210.3421-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207121704210.3421-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 14 Jun 2002 21:54:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 05:05:23PM -0600, Thunder from the hill wrote:
> Hi,
> 
> Possible fix for the show ones seems:
> 
> Index: include/linux/driverfs_fs.h
> ===================================================================
> RCS file: /var/cvs/thunder-2.5/include/linux/driverfs_fs.h,v
> retrieving revision 1.2
> diff -p -u -r1.2 driverfs_fs.h
> --- include/linux/driverfs_fs.h	9 Jul 2002 12:15:28 -0000	1.2
> +++ include/linux/driverfs_fs.h	12 Jul 2002 23:04:08 -0000
> @@ -41,8 +41,8 @@ struct driver_dir_entry {
>  
>  struct device;
>  
> -typedef ssize_t (*driverfs_show)(void * obj, char * buf, size_t count, loff_t off);
> -typedef ssize_t (*driverfs_store)(void * obj, const char * buf, size_t count, loff_t off);
> +typedef ssize_t (*driverfs_show)(struct device * obj, char * buf, size_t count, loff_t off);
> +typedef ssize_t (*driverfs_store)(struct device * obj, const char * buf, size_t count, loff_t off);

No, this patch is incorrect.  See Pat's patch that was posted a few
days ago.

And I don't think Richard really wants to be bothered with driverfs
questions :)

thanks,

greg k-h

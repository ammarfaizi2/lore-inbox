Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287868AbSBGQIf>; Thu, 7 Feb 2002 11:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288117AbSBGQIY>; Thu, 7 Feb 2002 11:08:24 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:48394 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287868AbSBGQIM>;
	Thu, 7 Feb 2002 11:08:12 -0500
Date: Thu, 7 Feb 2002 08:05:25 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Pharr <ben@benpharr.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: inode.c Compile Error
Message-ID: <20020207160524.GO14504@kroah.com>
In-Reply-To: <20020207151518.GA5184@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020207151518.GA5184@hst000004380um.kincannon.olemiss.edu>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 10 Jan 2002 01:35:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 09:15:18AM -0600, Benjamin Pharr wrote:
> I got the following error when trying to compile 2.5.4-pre2:

This patch fixes this.  I'll send it upstream later today.

thanks,

greg k-h


diff -Nru a/drivers/usb/inode.c b/drivers/usb/inode.c
--- a/drivers/usb/inode.c	Thu Feb  7 08:08:34 2002
+++ b/drivers/usb/inode.c	Thu Feb  7 08:08:34 2002
@@ -525,7 +525,7 @@
 static struct super_block *usb_get_sb(struct file_system_type *fs_type,
 	int flags, char *dev_name, void *data)
 {
-	return get_sb_single(fs_type, flags, data, usb_fill_super);
+	return get_sb_single(fs_type, flags, data, usbfs_fill_super);
 }
 
 static struct file_system_type usbdevice_fs_type = {

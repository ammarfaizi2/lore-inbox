Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318060AbSGLXC7>; Fri, 12 Jul 2002 19:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSGLXC6>; Fri, 12 Jul 2002 19:02:58 -0400
Received: from pD952ACB5.dip.t-dialin.net ([217.82.172.181]:50567 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318060AbSGLXC4>; Fri, 12 Jul 2002 19:02:56 -0400
Date: Fri, 12 Jul 2002 17:05:23 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: Compile warning in fs/partitions/check.c
In-Reply-To: <Pine.LNX.4.44.0207121640180.3421-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0207121704210.3421-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Possible fix for the show ones seems:

Index: include/linux/driverfs_fs.h
===================================================================
RCS file: /var/cvs/thunder-2.5/include/linux/driverfs_fs.h,v
retrieving revision 1.2
diff -p -u -r1.2 driverfs_fs.h
--- include/linux/driverfs_fs.h	9 Jul 2002 12:15:28 -0000	1.2
+++ include/linux/driverfs_fs.h	12 Jul 2002 23:04:08 -0000
@@ -41,8 +41,8 @@ struct driver_dir_entry {
 
 struct device;
 
-typedef ssize_t (*driverfs_show)(void * obj, char * buf, size_t count, loff_t off);
-typedef ssize_t (*driverfs_store)(void * obj, const char * buf, size_t count, loff_t off);
+typedef ssize_t (*driverfs_show)(struct device * obj, char * buf, size_t count, loff_t off);
+typedef ssize_t (*driverfs_store)(struct device * obj, const char * buf, size_t count, loff_t off);
 
 struct driver_file_entry {
 	struct driver_dir_entry * parent;

Not yet tested to compile, just on it...

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------


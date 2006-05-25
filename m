Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWEYD4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWEYD4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWEYD4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:56:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1492 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964889AbWEYD4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:56:17 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: "Rohan Mutagi" <rohan208@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.16.1 and kdb "error 6 mounting ext3" 
In-reply-to: Your message of "Wed, 24 May 2006 15:41:57 -0400."
             <91740af30605241241g3dc06954p3e6d5571185d15b5@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 May 2006 13:54:41 +1000
Message-ID: <7818.1148529281@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rohan Mutagi" (on Wed, 24 May 2006 15:41:57 -0400) wrote:
>Hey Guys,
> I am getting a -
>
>"Kernel panic - not syncing: attempted to kill init!"
>
>error when I try to run 2.6.16 kernel compiled with kdb support. Any
>ideas how to proceded further into this problem?
>
>Steps I took were:
>1. Got a fresh 2.6.16.1 kernel
>2. Applied the kdb patch from ftp://oss.sgi.com/www/projects/kdb/download/v4.4/
>3. make clean; make; make modules_install install; reboot;
>
>I am running this Linux RHEL inside VMWare. Now when I reboot to the
>2.6.16-kgb kernel..
>I get the following error after I choose the 2.6.16 kernel from grub!
>__________________________________
>Red Hat nash version 4.2.1.6 starting
>  Reading all physical volumes. This may take a while...
>  No volume groups found
>  Unable to find volume group "VolGroup00"
>ERROR: /bin/lvm exited abnormally! (pid 304)
>mount: error 6 mounting ext3
>mount: error 2 mounting none
>switchroot: mount failed: 22
>umount /initrd/dev failed: 2
>Kernel panic - not syncing: attempted to kill init!
>
>entering kdb due to KDB_ENTER()
>kdb>

This is appear to be a kdb problem.  The problem is that lvm could not
find the volume groups, the kdb patch does not touch lvm.  Just to be
sure, backout the kdb patch and rebuild, but I doubt it will make a
difference.


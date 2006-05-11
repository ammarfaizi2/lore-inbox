Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWEKIYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWEKIYr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWEKIYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:24:46 -0400
Received: from k2smtpout04-02.prod.mesa1.secureserver.net ([64.202.189.173]:7124
	"HELO k2smtpout04-02.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1030186AbWEKIYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:24:44 -0400
X-Antivirus-MYDOMAIN-Mail-From: razvan.g@plutohome.com via plutohome.com.secureserver.net
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(82.77.255.201):SA:0(-2.4/5.0):. Processed in 0.864634 secs Process 5889)
Message-ID: <4462F4E1.4060008@plutohome.com>
Date: Thu, 11 May 2006 11:25:05 +0300
From: Razvan Gavril <razvan.g@plutohome.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Coldpluging or USB Issues ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For start, i don't know if a big part of the problem is not cause by 
userland tools and not the kernel itself, but i think is proper to ask 
this questions here as there are a lot of people who can guide me to the 
right place to search for information.

We are developing a custom debian sarge based linux distribution focused 
on home entertainment & other. Since we made the switch from 2.6.13 to 
2.6.15 we come to a lot of problems cause by coldpluging, sometimes the 
module for various usb devices are not loaded at boot (by the hotplug 
scripts). Since the hotplug script that we use with 2.6.15 are the same 
with the one that we've been using with 2.6.13 i suspect that something 
in the kernel changed because they used to work flawless with the older 
version. For the last week we updated to 2.6.16.12 hoping that it fixes 
this issue but nothing has changed, the problem is still there, we even 
had bigger problem, not directly related to coldplug, when a computer 
had multiple usb devices attached it worked for a while that all the usb 
system stoped working, when rebooting , it even blocked when loading the 
modules for usb, we needed to remove some of the usb devices to get it 
boot again.

We tried switching from the debian default bash hotplug scripts and use 
a alternative version written in perl but the problem are still there so 
the idea that this has something to do with the kernel is getting closer 
to reality.

As far as i know since 2.6.15 there is a new coldplug mechanism using 
uevent and switching to a newer version of udevd that can do the cold 
plugging and replacing the old hotplug scripts would be the natural next 
step but before doing this i need to ask some questions like :
 1) Where there any changes sine 2.6.15 that could cause the old hotplug 
scripts to work reliable because most part of the time (95%) they are 
working ?
 2) Upgrading to newer version of udevd to let the udev scripts to do 
the coldpluging can solve any issues that where described ?

If any of you wants to debug the problems fill free to contact me as i 
can provide you with all the needed information.

Thx

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVBJHkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVBJHkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 02:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVBJHkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 02:40:06 -0500
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:6418 "EHLO
	three.holviala.com") by vger.kernel.org with ESMTP id S262038AbVBJHkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 02:40:00 -0500
Message-ID: <420B0FCD.4000801@holviala.com>
Date: Thu, 10 Feb 2005 09:39:57 +0200
From: Kim Holviala <kim@holviala.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Spontaneous reboot with 2.6.10 and NFSD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hit an obscure bug last night when trying to copy files from an nfs 
client to my nfs server. The server is a P3/800 with three IDE disks in 
software RAID5 running vanilla 2.6.10 and Debian Sarge. The network is 
local 100Mbit/s switched ethernet. The server exports a 220 gig 
partition which contains a lot of data.

Oh, kernel configs and stuff from the server can be found from:
http://www.holviala.com/~kimmy/crash/

Anyway, I mount the export to a Linux client (tried with a few with 
different 2.6 kernels and distros) and then start copying files from 
clients CDROM to the server through NFS. After copying a few small 
files, the first big one reboots the server. There are no log entries, 
and the server has no local console so I don't know what happens. This 
is reproduceable 100% of the time.

To narrow down the problem, I've tried the following:

- copied files from a different client running Gentoo: reboot
- exported a non-raided partition (hdc9) and tried that: reboot
- switched 2.6.10 to 2.6.11-rc3: reboot, but it took longer

I hope it's just something that I've done, but this server has been in 
use for a long time now without any problems, and I haven't touched it 
for a while.

So, if anyone knows what's wrong, or can tell me a way to debug the 
situation more I'd be grateful. The server is in a place where it's 
nearly impossible to have a local console - I could probably use a 
serial one if necessary for debugging.



Kim


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVCZVvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVCZVvf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 16:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVCZVve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 16:51:34 -0500
Received: from [212.160.85.18] ([212.160.85.18]:4362 "EHLO
	pc90.rabka.sdi.tpnet.pl") by vger.kernel.org with ESMTP
	id S261307AbVCZVv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 16:51:29 -0500
Message-ID: <4245D8A9.1070406@dubielvitrum.pl>
Date: Sat, 26 Mar 2005 22:48:25 +0100
From: Leszek Dubiel <Leszek.Dubiel@dubielvitrum.pl>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE driver + kernel compilation options == disc detection
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
DubielVitrum: delivered
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like somebody more experienced to help me, because even though I 
have read a lot about IDE kernel driver I didn't manage to find any 
answer for the question I describe below. I have asked for quite time on 
other groups but nobody helped me. I have gone through google on groups 
and even if the problem of disk geometry was discussed a lot I didn't 
find an answer.

My system is Debian Woody. May disks are both set to LBA and I don't 
change anything during experiment. On Ide0 and Ide1 there are two 
identical Samsung disks 120Gb. Both have identical parameters in Bios. 
Samsung documentation states that CHS=232632/16/63. On both are 
identical partions (sfdisk -d /dev/hda | sfdisk /dev/hdc).

Now I compile the kernel twice -- first time I use original config of 
Debian Woody, and then I start from scratch.
Kernel version is 2.4.18.

With first kernel (original from Debian Woody) discs are seen as:

hda: 234493056 sectors (120060 MB) w/8192KiB Cache, CHS=232632/16/63
hdc: 234493056 sectors (120060 MB) w/8192KiB Cache, CHS=232632/16/63

while on my kernel it looks like:

hda: 234493056 sectors (120060 MB) w/8192KiB Cache, CHS=14596/255/63
hdc: 234493056 sectors (120060 MB) w/8192KiB Cache, CHS=232632/16/63


Why during the second boot kernel didn't detect drive hda correctly? I 
think the ide driver in both kernels is identical, so why discs are seen 
differently? I know that disk geometry is only for lilo and [cfs]disk, 
but kernel should be deterministic and detect disks always the same...

I ask you to help me, because I've been searching for answer quite a 
long and no howtos, no lkml archives, no other resources gave me
any hint to get an answer.

Thank you in advance.

Leszek Dubiel
www.glass.biz
Poland

PS. I know that I can work around this problem, I know how to force 
cfdisk and lilo. The only thing I don't know is "WHY" they didn't get 
detected the same with both kernels.







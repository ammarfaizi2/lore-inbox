Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWIZBeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWIZBeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 21:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWIZBeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 21:34:31 -0400
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:11747 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1750741AbWIZBeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 21:34:31 -0400
Message-ID: <451883A2.3090009@lwfinger.net>
Date: Mon, 25 Sep 2006 20:34:26 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Bug (or Feature) in the swap system
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my system, I used to have two smallish swap partitions on hda3 and hda7. When I upgraded my hard 
drive, I increased the size of hda7 and planned to mount hda3 as /boot. Accordingly, I formatted it 
as an ext3 partition, but failed to modify fstab.

When I first booted with the new drive, I noticed the error message that it was unable to find a 
swap space signature; therefore, I checked the swap space with the free command and was satisfied to 
see 1250 MB of swap space. Everything seemed fine when the system was first booted; however any 
sizable task such as a kernel build would proceed very slowly. From top, I learned that the cpu 
usage by the system was in the 85-90% range. It was impossible to move the mouse, or to do anything 
interactive. Process kswapd0 would run frequently, but no swap space was ever used. As hda3 had 
never been used, it was simple to change it to a swap partition, format it, and issue a swapon. 
IMMEDIATELY, the system was normal!

Getting back to my subject line: Is this an obscure bug or a feature designed to punish idiots that 
cannot set up their swap space correctly?

Thanks,

Larry

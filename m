Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282075AbRKWGss>; Fri, 23 Nov 2001 01:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282076AbRKWGsi>; Fri, 23 Nov 2001 01:48:38 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:53987 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S282075AbRKWGse>; Fri, 23 Nov 2001 01:48:34 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: fstab swap options obscolete?
Date: Fri, 23 Nov 2001 01:48:33 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011123064837Z282075-17408+17667@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get multiple swap partitions/files to work at the same priority, 
you'd use the pri=NUM option in /etc/fstab.   
Now i've set this (pri=-1) on both and dmesg shows that they still get added 
at different priorities.  first -1, second -2.   Now if i swapoff them and 
swapon them  it starts at -3   even though there is no longer a -1 or -2.  Is 
this correct behavior?     
I'm kinda going on the assumption that loading multiple swap partitions 
together at the same priority will basically make the kernel use them in a 
striping mode.  Is this the case?   If not, how would i specifiy priority 
besides merely the order they're placed in /etc/fstab  ?

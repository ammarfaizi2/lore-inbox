Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316057AbSENVMU>; Tue, 14 May 2002 17:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316058AbSENVMT>; Tue, 14 May 2002 17:12:19 -0400
Received: from sm10.texas.rr.com ([24.93.35.222]:60904 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S316057AbSENVMS>;
	Tue, 14 May 2002 17:12:18 -0400
Date: Tue, 14 May 2002 16:12:18 -0500 (CDT)
From: Jeff Meininger <jeffm@boxybutgood.com>
X-X-Sender: jeffm@spaz.localdomain
To: linux-kernel@vger.kernel.org
Subject: how to map "/dev/root" to "/proc/partitions" entry in user prog?
Message-ID: <Pine.LNX.4.44.0205141554240.2160-100000@spaz.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In a user program, you can read /proc/partitions to determine what disks 
and partitions are available, and you can read /proc/mounts to see which 
of them are mounted, and where.

However, on many configurations, /proc/mounts will list "/dev/root" 
instead of the corresponding entry in /proc/partitions (such as /dev/hda1 
or /dev/ide/host0/...).

How can I reliably map /dev/root to the corresponding entry in 
/proc/partitions?  Is there some /proc thing I'm missing, or is there an 
ioctl that can give me the information I'm looking for?

The only way I've been able to do this so far is to read in the output of
the "mount" command, or read fstab or mtab.  Reading fstab or mtab is
unreliable, because they don't necessarily contain accurate information.  
Parsing the output of "mount" seems kludgy, and introduces a lot of
complexity because it might list /dev/hda1 instead of
/dev/ide/host0/.../part1, thus requiring an additional layer of mapping.  
Plus, the "mount" command might not be available at all.

Whether devfs is running or not, I just want to be able to figure out
which device in /proc/partitions corresponds to /dev/root.

Thanks very much for your help!!
Please Cc me in your response.

-Jeff Meininger


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282162AbRKWPnw>; Fri, 23 Nov 2001 10:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282170AbRKWPnm>; Fri, 23 Nov 2001 10:43:42 -0500
Received: from mail1.arcor-ip.de ([145.253.2.10]:9618 "EHLO mail1.arcor-ip.de")
	by vger.kernel.org with ESMTP id <S282162AbRKWPnY>;
	Fri, 23 Nov 2001 10:43:24 -0500
Message-ID: <3BFE6E98.8090109@arcormail.de>
Date: Fri, 23 Nov 2001 16:43:20 +0100
From: Hartmut Holz <hartmut.holz@arcormail.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Input/output error
In-Reply-To: <Pine.LNX.4.33.0111221415490.1518-100000@grignard.amagerkollegiet.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Bøg Hansen wrote:

> On Thu, 22 Nov 2001, Marcus Grando wrote:
> 
> 
>>On try start syslog deamon occur this errrors "Input/output error" on many archives /var directory.
>>
> 
> Try to run fsck on the /var partition. Also you should check the disk 
> for bad blocks. What output do you get from the kernel ('dmesg', 
> /var/log/messages etc.)?
> 
> It could be a bad disk developing bad sectors.
> 
> Rasmus
> 
> 

On my machine (2.4.15 final) it is the same behaviour.  After reboot
the lock files (and only the lock files) are corrupt. With 2.4.14 and 
2.4.13 everything works fine. gcc 2.96, e2fsck 1.25, aic7896/97

e2fsck output:
--------------
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Entry 'kudzu' in /lock/subsys (30001) has deleted/unused inode 30005. 
Clear? yes

Entry 'network' in /lock/subsys (30001) has deleted/unused inode 30006. 
  Clear? yes

Entry 'syslog' in /lock/subsys (30001) has deleted/unused inode 30007. 
Clear? yes

Entry 'portmap' in /lock/subsys (30001) has deleted/unused inode 30008. 
  Clear? yes

Entry 'nfslock' in /lock/subsys (30001) has deleted/unused inode 30009. 
  Clear? yes

Entry 'random' in /lock/subsys (30001) has deleted/unused inode 30012. 
Clear? yes

Entry 'netfs' in /lock/subsys (30001) has deleted/unused inode 30013. 
Clear? yes

Entry 'autofs' in /lock/subsys (30001) has deleted/unused inode 30014. 
Clear? yes

Entry 'local' in /lock/subsys (30001) has deleted/unused inode 30029. 
Clear? yes

Entry 'syslogd.pid' in /run (38001) has deleted/unused inode 38009. 
Clear? yes

Entry 'klogd.pid' in /run (38001) has deleted/unused inode 38010. 
Clear? yes

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/var: ***** FILE SYSTEM WAS MODIFIED *****
/var: 23017/66000 files (5.9% non-contiguous), 115364/263168 blocks



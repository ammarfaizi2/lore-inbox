Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282209AbRKWTKq>; Fri, 23 Nov 2001 14:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282210AbRKWTKh>; Fri, 23 Nov 2001 14:10:37 -0500
Received: from mail.shorewall.net ([206.124.146.177]:6916 "HELO
	mail.shorewall.net") by vger.kernel.org with SMTP
	id <S282209AbRKWTK1> convert rfc822-to-8bit; Fri, 23 Nov 2001 14:10:27 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Tom Eastep <teastep@shorewall.net>
To: Hartmut Holz <hartmut.holz@arcormail.de>, linux-kernel@vger.kernel.org
Subject: Re: Input/output error
Date: Fri, 23 Nov 2001 11:10:25 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0111221415490.1518-100000@grignard.amagerkollegiet.dk> <3BFE6E98.8090109@arcormail.de>
In-Reply-To: <3BFE6E98.8090109@arcormail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <20011123191025.D74BDAD02@mail.shorewall.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 November 2001 07:43 am, Hartmut Holz wrote:
> Rasmus Bøg Hansen wrote:
> > On Thu, 22 Nov 2001, Marcus Grando wrote:
> >>On try start syslog deamon occur this errrors "Input/output error" on
> >> many archives /var directory.
> >
> > Try to run fsck on the /var partition. Also you should check the disk
> > for bad blocks. What output do you get from the kernel ('dmesg',
> > /var/log/messages etc.)?
> >
> > It could be a bad disk developing bad sectors.
> >
> > Rasmus
>
> On my machine (2.4.15 final) it is the same behaviour.  After reboot
> the lock files (and only the lock files) are corrupt. With 2.4.14 and
> 2.4.13 everything works fine. gcc 2.96, e2fsck 1.25, aic7896/97

A "me too" here (2.4.15 final) -- ran fsck on the /var partition and saw 
output similar to that below.
>
> e2fsck output:
> --------------
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Entry 'kudzu' in /lock/subsys (30001) has deleted/unused inode 30005.
> Clear? yes
>
> Entry 'network' in /lock/subsys (30001) has deleted/unused inode 30006.
>   Clear? yes
>
> Entry 'syslog' in /lock/subsys (30001) has deleted/unused inode 30007.
> Clear? yes
>
> Entry 'portmap' in /lock/subsys (30001) has deleted/unused inode 30008.
>   Clear? yes
>
> Entry 'nfslock' in /lock/subsys (30001) has deleted/unused inode 30009.
>   Clear? yes
>
> Entry 'random' in /lock/subsys (30001) has deleted/unused inode 30012.
> Clear? yes
>
> Entry 'netfs' in /lock/subsys (30001) has deleted/unused inode 30013.
> Clear? yes
>
> Entry 'autofs' in /lock/subsys (30001) has deleted/unused inode 30014.
> Clear? yes
>
> Entry 'local' in /lock/subsys (30001) has deleted/unused inode 30029.
> Clear? yes
>
> Entry 'syslogd.pid' in /run (38001) has deleted/unused inode 38009.
> Clear? yes
>
> Entry 'klogd.pid' in /run (38001) has deleted/unused inode 38010.
> Clear? yes
>
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
>
> /var: ***** FILE SYSTEM WAS MODIFIED *****
> /var: 23017/66000 files (5.9% non-contiguous), 115364/263168 blocks
>

-Tom
-- 
Tom Eastep    \  teastep@shorewall.net
AIM: tmeastep  \  http://www.shorewall.net
ICQ: #60745924  \_________________________

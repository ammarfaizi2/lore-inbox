Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287647AbSBOIWQ>; Fri, 15 Feb 2002 03:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287681AbSBOIWD>; Fri, 15 Feb 2002 03:22:03 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:48655 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S287647AbSBOIVo>; Fri, 15 Feb 2002 03:21:44 -0500
Message-ID: <3C6CC4D9.C624F4A9@aitel.hist.no>
Date: Fri, 15 Feb 2002 09:20:41 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.4-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange disk-write speeds
In-Reply-To: <Pine.LNX.3.95.1020214111438.31768A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> Weird. I have two identical SCSI drives. They both synchronize
> at 40 Mb/s on my Buslogic controller. They are the two ...
>     Vendor: SEAGATE  Model: ST318233LWV      Rev: 0002
> ... drives shown below.
> 
> They both have ext2 file-systems occupying a single partition.
> The time to write a file that fills up the file-system on the
> "Id: 01" drive is about 1/2 an hour and the time to write a
> file that fills up the file-system on "Id: 02" is about 1/2 day!
> 
> This is with the file created with "O_SYNC". If the file is
> not created with "O_SYNC", there is no apparent difference in
> write speed.
> 
> If I swap the jumpers on the two drives to isolate the drives
> from the problem, the slooooo drive is the logical "ID: 02",
> always... not the physical one!
> 

O_SYNC writes takes different time depending on the scsi ID?

_Very_ strange, unless your /etc/fstab looks different for
/dev/sdbX and /dev/sdcX  
I.e. different mount options that indeed depend on scsi id.
Also check to make sure nothing else is running and accessing
any partition on sdc, that might force those sync writes
to seek more.  (I guess the slow disk is noisy?)

Helge Hafting

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbRCAJkl>; Thu, 1 Mar 2001 04:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129574AbRCAJkb>; Thu, 1 Mar 2001 04:40:31 -0500
Received: from 203-79-82-83.adsl-wns.paradise.net.nz ([203.79.82.83]:64200
	"HELO volcano.plumtree.co.nz") by vger.kernel.org with SMTP
	id <S129568AbRCAJkX>; Thu, 1 Mar 2001 04:40:23 -0500
Date: Thu, 1 Mar 2001 22:40:19 +1300
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: Mike Maravillo <mike.maravillo@q-linux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange hdparm behaviour with Via 686b and 2.4.2
Message-ID: <20010301224018.E985@cone.kiwa.co.nz>
In-Reply-To: <20010301205930.B9243@cone.kiwa.co.nz> <20010301164959.A11065@mail.q-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010301164959.A11065@mail.q-linux.com>; from mike.maravillo@q-linux.com on Thu, Mar 01, 2001 at 04:49:59PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 04:49:59PM +0800, Mike Maravillo wrote:
> I'm not sure if this one is related.  This is on an AMD K6-2 450
> with MS-5187 board and VIA VT82C686A chipset...

Should have add this in the last message.   Almost exactly the same system
same HDD, KT7 (with 686A) motherboard and a Duron 700, running:


[nic@hoppa:~] uname -a
Linux hoppa 2.2.18pre21 #1 Fri Dec 22 02:27:39 NZDT 2000 i686 unknown



[nic@hoppa:~/dnetc] w
  9:11pm  up 63 days, 12:32,  1 user,  load average: 0.99, 0.97, 0.91

[nic@hoppa:~/dnetc] sudo hdparm -Tt /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.18 seconds =108.47 MB/sec
 Timing buffered disk reads:  64 MB in  2.29 seconds = 27.95 MB/sec
[nic@hoppa:~/dnetc] w
[nic@hoppa:~/dnetc] ./dnetc -shutdown
dnetc: 1 distributed.net client was shutdown. 0 failures.
[nic@hoppa:~/dnetc] sudo hdparm -Tt /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.14 seconds =112.28 MB/sec
 Timing buffered disk reads:  64 MB in  2.26 seconds = 28.32 MB/sec

[nic@hoppa:~] sudo hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  1 (on)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2480/255/63, sectors = 39851760, start = 0



That's the sort of behaviour you'd expect.

Nicholas


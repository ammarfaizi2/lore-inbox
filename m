Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRDMQCR>; Fri, 13 Apr 2001 12:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbRDMQCH>; Fri, 13 Apr 2001 12:02:07 -0400
Received: from unthought.net ([212.97.129.24]:10112 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S131457AbRDMQBx>;
	Fri, 13 Apr 2001 12:01:53 -0400
Date: Fri, 13 Apr 2001 18:01:52 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Andreas Peter <ujq7@rz.uni-karlsruhe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SW-RAID0 Performance problems
Message-ID: <20010413180152.A13740@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Andreas Peter <ujq7@rz.uni-karlsruhe.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01041313473002.00533@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <01041313473002.00533@debian>; from ujq7@rz.uni-karlsruhe.de on Fri, Apr 13, 2001 at 01:47:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 01:47:30PM +0200, Andreas Peter wrote:
> Hi,
> I've successfully set up SW-RAID0 with Kernel 2.4.3 and Raidtools 0.9.
> I did this to increase the performance of my HD, but nothig happens.
> The hdparm results:
> hdparm -t /dev/md0 : 20.25 MB/sec
> hdparm -t /dev/hda : 20.51 MB/sec
> hdaprm -t /dev/hdc : 20.71 MB/sec
> 
> I thougt the performnace of RAID0 should near 40MB/sec.
> I played with different chunk-sizes, but the result was everytime the same.
> The drives are both Maxtor DiamondMax VL40, 30GB, DMA on. 
> No other drive is attached on the bus.
> 
> Here are also some bonnie++ results:
...

I can't say much about this... It looks like your setup is perfectly allright,
and the performance *should* go up.   Instead it looks like you get a small
performance drop from using the RAID.   Most odd.

Do you have more controllers in the machine ? If so could you try to move eg.
hdc to the second controller ?  The only thing I can imagine being the cause of
the poor performance is, if your controller somehow doesn't handle both
channels very well simultaneously.   It's far fetched, but it's the only
suggestion I can think of.

Maybe Andre has comments ?

I usually get a good speedup from using RAID-0 on 2.4.3 with IDE.  Both with
two disks and with six.   This is with Intel PIIX4 and Promise 20262
controllers.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

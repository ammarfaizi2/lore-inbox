Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273053AbRIRRaV>; Tue, 18 Sep 2001 13:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273047AbRIRRaM>; Tue, 18 Sep 2001 13:30:12 -0400
Received: from unthought.net ([212.97.129.24]:29401 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S273028AbRIRRaA>;
	Tue, 18 Sep 2001 13:30:00 -0400
Date: Tue, 18 Sep 2001 19:30:23 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: Re: bdflush and postgres stuck in D state
Message-ID: <20010918193023.P29908@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010918125605.F29908@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010918125605.F29908@unthought.net>; from jakob@unthought.net on Tue, Sep 18, 2001 at 12:56:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for following up on my own post, I have a little extra
information.

I started a g++ job to try to force the machine to write out some dirty
buffers before I reboot.   g++ now hangs along with two sync's, bdflush
and the postgres process.

This is from top:

  PID USER     PRI  NI  SIZE  RSS SHARE WCHAN     STAT %CPU %MEM   TIME COMMAN
    6 root       9   0     0    0     0 raid1_all DW    0.0  0.0   0:26 bdflush
 1140 joe        9   0 71564  39M     0 wait_on_b D     0.0 32.3   1:04 cc1plus
 1007 root       9   0    72    4     4 wait_on_b D     0.0  0.0   0:00 sync
10023 postgres   9   0   368    4     4 wait_on_b D     0.0  0.0   0:00 postmas


Seems like something's rotten with bdflush and raid1_all (-something).

There is one (software) RAID1 on four SCSI disks in the machine, perhaps RAID1
has a misfeature when more than just two disks are in the mirror ?

Anyway, this machine is going down now - I can't wait anymore, sorry. I wonder
how many file writes didn't make it...

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318117AbSIHQLa>; Sun, 8 Sep 2002 12:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSIHQLa>; Sun, 8 Sep 2002 12:11:30 -0400
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:27271 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S318117AbSIHQL3>; Sun, 8 Sep 2002 12:11:29 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: ide drive dying?
Date: Sun, 8 Sep 2002 02:02:35 +0200
User-Agent: KMail/1.4.3
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209080159.47115.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Sep 2002, Andre Hedrick wrote:
> On 7 Sep 2002, Daniel Egger wrote:
>
> > Am Sam, 2002-09-07 um 17.02 schrieb jbradford@dial.pipex.com:
> > 
> > > No, but you've upgraded the firmware, right?
> > 
> > Not exactly. According to IBM technical support there is no such thing
> > as a new firmware. The drives are alright, the OS is broken.
>
> They are full of CRAP!
>
> IBM ran TASKFILE IO throught there bus analyzers and it came up clean.
> IBM also introduced FLAGGED versions of the diagnostic TASKFILE transport
> for eventual use of their DFT (Drive Fitness Test).
>
> You tell the service tech he is smoking crack.
> The kernel passed with flying colors in their disk labs. If you read
> in ide-taskfile.c version 0.33 and above, you will see they did some work
> on the driver and verified issues.

Sorry, that I step in but you said that you are working on smartsuite (2.1+), 
again?

Andre, can you fix start/stop counts, please?

unWave1 /home/nuetzel# /usr/local/sbin/smartctl -a /dev/sda
Device: IBM      DDYS-T18350N     Version: S96H
Device supports S.M.A.R.T. and is Enabled
Temperature Warning Disabled or Not Supported
S.M.A.R.T. Sense: Okay!
Current Drive Temperature:     31 C
Drive Trip Temperature:        85 C
Current start stop count:      131072 times
Recommended start stop count:  2555920 times

SunWave1 /home/nuetzel# /usr/local/sbin/smartctl -a /dev/sdb
Device: IBM      DDRS-34560D      Version: DC1B
Device supports S.M.A.R.T. and is Enabled
Temperature Warning Disabled or Not Supported
S.M.A.R.T. Sense: Okay!

SunWave1 /home/nuetzel# /usr/local/sbin/smartctl -a /dev/sdc
Device: IBM      DDRS-34560W      Version: S71D
Device supports S.M.A.R.T. and is Enabled
Temperature Warning Disabled or Not Supported
S.M.A.R.T. Sense: Okay!

Smartsuite-2.1 (at least) missing some feather for SCSI.

Regards,
	Dieter

BTW
I had a double disk crash (same symptoms as in this thread) in a school's 
RAID5 with four Fujitsu MPG3204AT-EF (the ones with gel-lager, silent and 
reliable we hoped) last week...
The shop for which I work from time to time got 71 disks of this type back 
(sold over the last 1.5 years). We switched to them after the "IBM" disaster. 
Maybe a "misdecision" ;-)
What shall we sell safely, now...?
MAXTOR?

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131455AbRCSMUs>; Mon, 19 Mar 2001 07:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131450AbRCSMUj>; Mon, 19 Mar 2001 07:20:39 -0500
Received: from secure.webhotel.net ([195.41.202.80]:32030 "HELO
	secure.webhotel.net") by vger.kernel.org with SMTP
	id <S131444AbRCSMUX>; Mon, 19 Mar 2001 07:20:23 -0500
X-Authenticated-Timestamp: 13:22:59(CET) on March 19, 2001
Message-ID: <3AB5F86E.69B3593C@netgroup.dk>
Date: Mon, 19 Mar 2001 13:15:42 +0100
From: Peter Lund <firefly@netgroup.dk>
Organization: NetGroup A/S
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: esound (esd), 2.4.[12] chopped up sound
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On my home machine playing sound through esd has worked beautifully on various
kernels from 2.2.5 and up to 2.2.18.  

On 2.4.1 and 2.4.2 it stinks.

It sounds like there are small pauses or repetitions in the sound, as if esd
doesn't get
the data quickly enough from the client or something.  Music and voices
(realaudio radio) still easy to understand but it does get on my nerves after a
few minutes :(

I've tested it on a freshly booted machine without X and gnome, only the bare
essentials for the machine + esd + esdcat (I converted one of my mp3's into raw
audio for the test).
It sounds the same the first, second, and third time I try so I don't think it
is because the hard disk can't keep up.  Besides, I stopped after about 10
seconds so it should all be in the cache after the first time.


The machine is a 400 MHz K6-2 with a VIA<something> chipset, the harddisk used
is a Quantum lct10 30 (30 GB).  Yes, DMS is enabled, I get a read bandwidth of
about 12.5 MB/s.

I have also tried Andrew Morton's low latency patches for both 2.4.1 and 2.4.2
but that doesn't help.  According to Benno's latency tests I get quite good
(low) latencies with just a normal 2.4.[12] kernel as long as DMA transfer is
enabled.

The lmbench results seem pretty normal, too, once the DMA transfer is enabled,
except for one small anomaly: Debian's 2.2.18pre21compact kernel was a bit
faster than the 2.2.18 kernel I compiled myself.


My theory is that this is a "scheduling delay" effect, i.e. esd or the process
sending data to esd is ready to run but some other unrelated process gets there
first and runs for a little while.  Any ideas on how to test this?  LTT doesn't
have patches for 2.4.[12] yet...


I can't access my home machine from here because it is behind a stupid NAT'ing
router, but I can try whatever you throw at my and/or get more information,
there's just a little timelag because it will have to wait until I'm home (I
/can/ access my work machine from home).

-Peter

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276150AbRJGGJn>; Sun, 7 Oct 2001 02:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276170AbRJGGJe>; Sun, 7 Oct 2001 02:09:34 -0400
Received: from robur.slu.se ([130.238.98.12]:11020 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S276150AbRJGGJS>;
	Sun, 7 Oct 2001 02:09:18 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15295.61967.701804.309307@robur.slu.se>
Date: Sun, 7 Oct 2001 08:11:27 +0200
To: kuznet@ms2.inr.ac.ru
Cc: adilger@turbolabs.com (Andreas Dilger), Robert.Olsson@data.slu.se,
        mingo@elte.hu, hadi@cyberus.ca, linux-kernel@vger.kernel.org,
        bcrl@redhat.com, netdev@oss.sgi.com, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <200110051917.XAA23007@ms2.inr.ac.ru>
In-Reply-To: <20011005124824.F315@turbolinux.com>
	<200110051917.XAA23007@ms2.inr.ac.ru>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kuznet@ms2.inr.ac.ru writes:

 > "some hysteresis" is right word. This loop is an experiment with still
 > unknown result yet. Originally, Jamal proposed to spin several times.
 > I killed this. Robert proposed to check inifinite loop yet. (Note,
 > jiffies check is just a way to get rid of completely idle devices,
 > one jiffie is enough lonf time to be considered infinite).
 > 

 And from our discussion about packet-reordering we get even more motivation
 for the "extra-polls" not only to save IRQ's 

 We may expand this to others too...

 As polling-lists are per CPU and consecutive polls stays within the same
 CPU the device becomes bound to one CPU. We are protected against packet 
 reordering as long there are consecutive polls.

 I've consulted some CS people who has worked with this issues and I have
 understood packet reordering is non-trivial problem at least with a general 
 approach.

 So to me it seems we do very well with a very simple scheme and as I 
 understand all SMP networking will benefit from this.

 Our "field-test" indicates that the packet load is still well distributed 
 among the CPU's.

 So maybe the showstopper comes out as a showwinner. :-)

 Cheers.

						--ro

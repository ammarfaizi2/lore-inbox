Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTIEAXO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 20:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTIEAXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 20:23:14 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:1514 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261380AbTIEAXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 20:23:11 -0400
Message-ID: <3F57D776.4050404@ameritech.net>
Date: Thu, 04 Sep 2003 19:23:18 -0500
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4  on to mpegs and DVB
References: <3F560DC6.2090709@ameritech.net>
In-Reply-To: <3F560DC6.2090709@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok...

So I switched to the following suggested utilities:

module-init-tools-0.9.13-0.2bor.src.rpm
hotplug-2003_08_05-0.1bor.src.rpm
initscripts-7.06-18mdk.1bor.src.rpm

then did a merge on modprobe.conf/rpmnew and added one little directory 
to the path in the sysinit file.

The printer is still hosed but I do see the usb tree under proc now.
Everything else needed excepting the BT848 card (i2 stuff and video) 
probed and loaded.  So I insmoded the rest to continue testing.

Mandrake will need to get their SUPERMOUNT working for DVDs, CDs and floppy.

Now for some performance reports.  I have a server, in the basement, 
with mp3s, mpegs and such being served via samba to the local net.
MP3's seemed to be ok but mpeg was awful.  Now the local net is a 24 
port switch that should be able to do 100mbits/full duplex (it does 
under 2.4). So, to see if it was networking at fault (I, also, had to 
switch to E100 as the eepro100 driver doesn't seem to work in 2.6), I 
played a local DVD.  The DVD looked and sounded great, but, it was using 
98% of the CPU!  2.4 never used that much.   I am wondering if the 
timing in the dispatcher is a tad off for video or if the different 
timeslices that are generated are not able to resonate with video 
display/capture/frame frequencies.  Should the timing for desktops tend 
to have some sort of natural resonance with motion video display 
critical timing?  (lots of folks watch mpegs and dvi and dvd ...)





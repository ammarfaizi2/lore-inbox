Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSFVRld>; Sat, 22 Jun 2002 13:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSFVRlc>; Sat, 22 Jun 2002 13:41:32 -0400
Received: from swm.pp.se ([195.54.133.5]:5068 "EHLO uplift.swm.pp.se")
	by vger.kernel.org with ESMTP id <S316797AbSFVRlc>;
	Sat, 22 Jun 2002 13:41:32 -0400
Date: Sat, 22 Jun 2002 19:41:26 +0200 (CEST)
From: Mikael Abrahamsson <swmike@swm.pp.se>
To: linux-kernel@vger.kernel.org
Subject: max buffering per disk?
Message-ID: <Pine.LNX.4.44.0206221930360.21527-100000@uplift.swm.pp.se>
Organization: People's Front Against WWW
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running the redhat 7.3 supplied 2.4.18-5smp kernel, and before that the 
redhat 7.2 supplied 2.4.9-31 kernel, I notice that I now get worse 
interactive performance when the machine is doing a lot of disk io. Using 
iostat/vmstat I see that there is not a lot of activity going on on the 
system drive, but rather on the drives containing a lot of files which are 
accessed/downloaded (web and ftp file serving).

I interpret this as that the files being service are being cached and the
caching of the mostly used files (on the system drive) is being thrown
out. Most of these files on the file-drives are only sent once and
therefore there is no use in caching them.

Is there some way of setting that the kernel can only use so much memory
to cache a specific drives content, or that a certain drive gets at least 
X amount of megs to cache its contents?

I have over 1 gig of memory and user processes usually don't use that much 
memory:

             total       used       free     shared    buffers     cached
Mem:       1160264    1150424       9840          0      66820     964292
-/+ buffers/cache:     119312    1040952
Swap:      4427928      30680    4397248

I would therefore like the system drive to always use say 128M or 256M for 
buffering it's contents, or as an alternative, say that my file drives 
cannot use more than 256M altogether for caching.

Is there a knob to do this, if not, is it anything that might be 
implemented in the future? I have read the tuning page 
<http://people.redhat.com/alikins/system_tuning.html#fs> and changed my 
bdflush settings accordingly but that didn't do much difference as far as 
I can see.

Btw, file serving performance is no problem, that works great, I can 
transfer 15-20Megabyte/s using my Netgear 622T card.

The 2.4.9 kernel seemed to have a better interactive performance on the
same load at the price of raw performance. I got slightly better
fileserving performance after upgrading to 2.4.18, but the interactive 
performance is much worse.

Any help appreciated.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se


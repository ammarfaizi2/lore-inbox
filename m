Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265867AbSKBCyz>; Fri, 1 Nov 2002 21:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265868AbSKBCyz>; Fri, 1 Nov 2002 21:54:55 -0500
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:2312 "EHLO
	skarpsey.dyndns.org") by vger.kernel.org with ESMTP
	id <S265867AbSKBCyy> convert rfc822-to-8bit; Fri, 1 Nov 2002 21:54:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: AlphaPC+Sym53c8xx driver failure, continued
Date: Fri, 1 Nov 2002 21:57:01 -0500
User-Agent: KMail/1.4.3
References: <3DC2E30E.13470.26B6B20E@localhost> <200211011722.50320.kelledin+LKML@skarpsey.dyndns.org> <200211011757.56812.kelledin+LKML@skarpsey.dyndns.org>
In-Reply-To: <200211011757.56812.kelledin+LKML@skarpsey.dyndns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211012057.01114.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Did you apply the core_cia.c patch?
> > > You can find it at
> > > http://knowledge.bruli.net/uploads/core_cia-patch.txt
>
> Sadly, no luck on it.  It doesn't seem to improve my situation
> at all. =(

I booted the Debian hack of 2.4.18 and got a little bit more 
informative set of debug messages:

ncr53c810-0: waiting 10 seconds for SCSI devices to settle...
freeing devtbl    [8192] @fffffc0000dee000
scsi0: ncr53c8xx-3.4.3b-20010512
ncr53c810-0-<0,0>: CMD=12 ncr53c810-0: command processing resumed
ncr53c810-0-<0,0>: CMD=12 <6>ncr53c810-0-<0,0>: ccb \
    @fffffc0000de8000 using tag 255
ncr53c810-0: queuepos=3.
scsi : aborting command due to timeout: pid 0, scsi0, channel \
    0, id 0, lun 0 Inquiry 00 00 00 ff 00
ncr53c8xx_abort: pid=0 serial_number=1 serial_number_at_timeout=1
ncr53c810-0: abort ccb=fffffc0000de8000 (cancel)

...and again, that's all she wrote.

Would anyone know where to find the actual maintainer for the 
ncr53c8xx driver?  It would appear to be Gerard Roudier, but I'd 
like to make sure before bugging him directly...

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"


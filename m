Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265902AbSKBJ21>; Sat, 2 Nov 2002 04:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265905AbSKBJ20>; Sat, 2 Nov 2002 04:28:26 -0500
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:17160 "EHLO
	skarpsey.dyndns.org") by vger.kernel.org with ESMTP
	id <S265902AbSKBJ20> convert rfc822-to-8bit; Sat, 2 Nov 2002 04:28:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: AlphaPC+SCSI, continued--SCSI layer broken?
Date: Sat, 2 Nov 2002 04:30:27 -0500
User-Agent: KMail/1.4.3
References: <3DC2E30E.13470.26B6B20E@localhost> <200211011757.56812.kelledin+LKML@skarpsey.dyndns.org> <200211012057.01114.kelledin+LKML@skarpsey.dyndns.org>
In-Reply-To: <200211012057.01114.kelledin+LKML@skarpsey.dyndns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211020330.27634.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 November 2002 08:57 pm, Kelledin wrote:
> > > > Did you apply the core_cia.c patch?
> > > > You can find it at
> > > > http://knowledge.bruli.net/uploads/core_cia-patch.txt
> >
> > Sadly, no luck on it.  It doesn't seem to improve my
> > situation at all. =(
>
> I booted the Debian hack of 2.4.18 and got a little bit more
> informative set of debug messages:
>
> ncr53c810-0: waiting 10 seconds for SCSI devices to settle...
> freeing devtbl    [8192] @fffffc0000dee000
> scsi0: ncr53c8xx-3.4.3b-20010512
> ncr53c810-0-<0,0>: CMD=12 ncr53c810-0: command processing
> resumed ncr53c810-0-<0,0>: CMD=12 <6>ncr53c810-0-<0,0>: ccb \
> @fffffc0000de8000 using tag 255
> ncr53c810-0: queuepos=3.
> scsi : aborting command due to timeout: pid 0, scsi0, channel
> \ 0, id 0, lun 0 Inquiry 00 00 00 ff 00
> ncr53c8xx_abort: pid=0 serial_number=1
> serial_number_at_timeout=1 ncr53c810-0: abort
> ccb=fffffc0000de8000 (cancel)
>
> ...and again, that's all she wrote.

Well, never mind the ncr53c8xx driver--the problem appears to be 
in the SCSI core code.  I threw in a QLogic ISP1040 controller 
and had much the same results.  Only difference is, I'm not sure 
how to gather debug output from the qlogicisp driver.  All I 
have is the QLogic driver freezing at about the same point...

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"


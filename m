Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267932AbTAHWPF>; Wed, 8 Jan 2003 17:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267894AbTAHWPF>; Wed, 8 Jan 2003 17:15:05 -0500
Received: from ns1.triode.net.au ([202.147.124.1]:8359 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S267932AbTAHWPE>; Wed, 8 Jan 2003 17:15:04 -0500
Message-ID: <3E1CA594.60407@torque.net>
Date: Thu, 09 Jan 2003 09:26:28 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: xhejtman@mail.muni.cz
Subject: Re: 2.5.54: ide-scsi still buggy?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
 > On Tue, Jan 07, 2003 at 09:17:46PM -0500, Zwane Mwaikambo wrote:
 > > > It freezes kernel (sysrq do nothing) after lines:
 > > > scsi0 : SCSI host adapter emulation for IDE ATAPI devices
 > > > Vendor: TEAC      Model: CD-W512EB         Rev: 2
 > > > Type:   CD-ROM                             ANSI SCSI revision: 02
 > > > scsi scan: host 0 channel 0 id 0 lun 0 identifier too long,
 > > > length 60, max 50. \
 > > > Device might be improperly identified.
 > > > while attaching it to /dev/hde works ok. Why?
 > >
 > > This has been observed to cause an oops on some boxes and nothing
 > > on mine,
 > > try this patch from Andries
 >
 > Acctualy this patch caused only I do not see "scsi scan:
 > host 0 channel 0 id
 > 0 lun 0 identifier too long, length 60, max 50. Device might
 > be improperly identified."
 >
 > how ever after above message kernel causes hard hw lockup.
 > IDE activity LED is turned on but nothing else works. (nor
 > sysrq)
 >
 > I believe that code that report this message causes hw lockup.
 > sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray

There are several different patches to ide-scsi in Linus's
snapshots that will most likely appear in lk 2.5.55 .
See:
http://www.kernel.org/pub/linux/kernel/v2.5/snapshots/
with patch-2.5.54-bk6 being the most recent. See the associated
log for a listing of the ide-scsi changes.

It would be interesting to hear if that snapshot fixes your
ide-scsi problem.

Doug Gilbert


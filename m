Return-Path: <linux-kernel-owner+w=401wt.eu-S1757365AbWLIDJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbWLIDJ4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 22:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758332AbWLIDJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 22:09:56 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:36354 "HELO
	mailer2-1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757365AbWLIDJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 22:09:55 -0500
Message-ID: <457A28FF.4030508@scientia.net>
Date: Sat, 09 Dec 2006 04:09:51 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: CD/DVD drive errors and lost ticks
References: <120320061552.9126.4572F2AD0001D571000023A622058844849D0E050B9A9D0E99@comcast.net>
In-Reply-To: <120320061552.9126.4572F2AD0001D571000023A622058844849D0E050B9A9D0E99@comcast.net>
Content-Type: multipart/mixed;
 boundary="------------070900040404010704000005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070900040404010704000005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi.


Sorry for my late reply,.. but I've been very busy this week (dozens of
new Sun Fires that hat to be installed, etc.) ;-)


Parag Warudkar wrote:
> It seems that your kernel is using IDE for your CDROM and libata for your other drives.
Yes it does.

> I recall having a similar problem with my laptop (DMA Disabled) when I had both IDE and SATA/PATA support enabled. I had to disable IDE altogether and let SATA/PATA drivers handle all my drives in order to get DMA on the CDROM.
>   
While this is a good idea in general,.. I doubt that it will solve my
problem,...
First of all,.. if this was a driver related issue it wouldn't happen
under windows (which I booted solely for testing reasons ;) ), too,
would it?
Secondly,... it seems that the drive isn't even able to read the CD
in,.. I mean I think that this is a drive internal issue and the drive
simply tells the kernel "wait,.. haven't read in yet" or so.
I've also hat some errors like this:
hdb: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: DMA disabled
hdb: ATAPI reset complete
hdb: irq timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdb: ATAPI reset complete
hdb: irq timeout: status=0x80 { Busy }
ide: failed opcode was: unknown
hdb: cdrom_read_intr: data underrun (4 blocks)
end_request: I/O error, dev hdb, sector 7831400
Buffer I/O error on device hdb, logical block 1957850
hdb: tray open
end_request: I/O error, dev hdb, sector 7831404
Buffer I/O error on device hdb, logical block 1957851
Buffer I/O error on device hdb, logical block 1957852
Buffer I/O error on device hdb, logical block 1957853
Buffer I/O error on device hdb, logical block 1957854
Buffer I/O error on device hdb, logical block 1957855
Buffer I/O error on device hdb, logical block 1957856
Buffer I/O error on device hdb, logical block 1957857
Buffer I/O error on device hdb, logical block 1957858
Buffer I/O error on device hdb, logical block 1957859
hdb: tray open
end_request: I/O error, dev hdb, sector 7831656
hdb: tray open
end_request: I/O error, dev hdb, sector 7831400
hdb: tray open
end_request: I/O error, dev hdb, sector 7831400
hdb: tray open
end_request: I/O error, dev hdb, sector 7831400
hdb: tray open
and so on and so on.

That happened on a DVD (successfully read in and played by the drive),..
but when I pushed the eject button (while xine sill was playing) I got
those errors,..
I assume that xine continued to read data but the DVD was already
ejected and thus the request errors....
But I think there shouldn't be a request error but more something like
"no medium found" or the eject button should have been disabled at
all,... so I think something goes really wrong with that drive ;)


> Try and pass ide=noprobe option to the kernel boot command line  and see if that makes a difference first - may be that will allow the SATA/PATA drivers to claim the CDROM before IDE sees it.
>
> If that won't work try and disable ATA/ATAPI/MFM/RLL support in your config and enable Serial ATA (prod) and Parallel ATA (experimental drivers) and select the right SATA drivers as built ins or modules (I think in your case it is going to be NVIDIA SATA support and/or AMD/Nvidia PATA support but I may be wrong). Then rebuild the kernel and see if your DVD drive has DMA and you can watch DVDs.
>   
I'll do that,.. but I've already contacted my seller,.. and asked for a
new device :-) But in the meantime I can test for this stuff.



Does anyone have some answers about the following:
I had some problems with my system the last months,.. first of all the
powersupply died,.. and then I've found some data corruption problems
(see my posts here on lkml).
I think the powersupply was simply damaged,.. and I assume (correct me
if it may be likely) that nothing else was damaged when the powersupply
broke.
The data corruption error is quite sure not a hardware defect of my
system but more likely a issue that all nvidia chipset boards (or at
least many of them) have.... (see my threads here at lkml)
But the DVD/CD defect makes me nervous,...
Is it likely that something in my system is defect and the damage
propagates to other components and makes them defect too?



Best wishes,
Chris,

--------------070900040404010704000005
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------070900040404010704000005--

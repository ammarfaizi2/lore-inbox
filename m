Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292852AbSBVNAd>; Fri, 22 Feb 2002 08:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292854AbSBVNAN>; Fri, 22 Feb 2002 08:00:13 -0500
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:14049 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S292852AbSBVNAD>; Fri, 22 Feb 2002 08:00:03 -0500
Date: Fri, 22 Feb 2002 13:59:07 +0100 (CET)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200202221259.g1MCx7v1007908@burner.fokus.gmd.de>
To: cdrecord-support@berlios.de, wpilorz@bdk.pl
Cc: Tony.P.Lee@nokia.com, alan@lxorguk.ukuu.org.uk, ed.sweetman@wmich.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [Cdrecord-support] OPC area usage [RE: ide cd-recording not working in 2.4.18-rc2-ac1 (fwd)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Wojtek Pilorz <wpilorz@bdk.pl>

>I am forwarding a message from linux-kernel mailing list;
>As far as I understand message from Tony Lee from Nokia,
>he says that you can not perform more then 10 calibrations on a CD-R
>media, and that to overcome that limitation some software (e.g. Easy CD
>Creator) stores information about media already calibrated on given
>drive in a database, so that when media is reused on that system, it is
>not calibrated again.

In many cases, it makes sense to _read_ the error message before commenting it.

The message is _not_ related to OPC!

>Would anyone care to comment whether this is true?
>If so, my undersanding is that it would be not possible to create more
>than 10 sessions on a CD-R media with cdrecord, which (as far as I
>understand) do not use such database. Is that correct?

You can do up to 99 OPC calls to a single media.


>> ---------- Forwarded message ----------
>> Date: Thu, 21 Feb 2002 12:23:43 -0800
>> From: Tony.P.Lee@nokia.com
>> To: ed.sweetman@wmich.edu, alan@lxorguk.ukuu.org.uk
>> Cc: linux-kernel@vger.kernel.org
>> Subject: RE: ide cd-recording not working in 2.4.18-rc2-ac1
>> 
>> > > > I get this on every cd I try and I've tried more than I'd 
>> > have liked to.
>> > > > 
>> > > > Performing OPC...
>> > > > 
>> > > /usr/bin/cdrecord: Input/output error. write_g1: scsi 
>> > sendcmd: no error
>> > > > CDB:  2A 00 00 00 00 1F 00 00 1F 00
>> > > > status: 0x2 (CHECK CONDITION)
>> > > > Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 21 00 00 00
>> > > > Sense Key: 0x5 Illegal Request, Segment 0
>> > > > Sense Code: 0x21 Qual 0x00 (logical block address out of 
>> > range) Fru 0x0
>> > > 
>> > > Thats saying that cdrecord sent the drive a bogus command.

The person who made the statement on the line above seems to lack any
basic knowlede....

Obviously a buffer underrun.

Possible reasons: 

-	Bad configuration (IDE cabling)

	- in this case it may help to read README.ATAPI

-	Bad configuration (SCSI setup)

	- In this case check cabling/termination and make sure
		all devices to disconnect/reconnect.

-	A kernel bug.

	- Ask for help from the Kernel crew.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix

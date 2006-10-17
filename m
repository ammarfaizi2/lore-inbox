Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWJQV3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWJQV3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWJQV24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:28:56 -0400
Received: from dxv01.wellsfargo.com ([151.151.5.42]:59558 "EHLO
	dxv01.wellsfargo.com") by vger.kernel.org with ESMTP
	id S1750786AbWJQV2w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:28:52 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Touchscreen hardware hacking/driver hacking.
Date: Tue, 17 Oct 2006 16:28:39 -0500
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D020C5EB1@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Touchscreen hardware hacking/driver hacking.
Thread-Index: AcbyMQAlmUmwm8/pSJei8KH7eSW2JgAAQdxg
From: <Greg.Chandler@wellsfargo.com>
To: <dtor@insightbb.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-input@atrey.karlin.mff.cuni.cz>,
       <andi@rhlx01.fht-esslingen.de>
X-OriginalArrivalTime: 17 Oct 2006 21:28:39.0971 (UTC) FILETIME=[36964730:01C6F233]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
In my many rounds of research on this, I'm pretty sure that this is the
same setup as the lifebook.
Wether the implementation is the same, is a matter of conjecture as long
as I can't see the device.

Both of you suggested checking the PS/2 under windows, unfortunatly I
know of no "sniffer" type drivers or apps
to listen directly on a logical PS/2 interface.  If you know where I can
find something like that that would be of more help than anything at
this point.



-----Original Message-----
From: dmitry.torokhov@gmail.com [mailto:dmitry.torokhov@gmail.com] On
Behalf Of Dmitry Torokhov
Sent: Tuesday, October 17, 2006 4:12 PM
To: Chandler, Greg
Cc: linux-kernel@vger.kernel.org; linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: Touchscreen hardware hacking/driver hacking.

On 10/17/06, Greg.Chandler@wellsfargo.com <Greg.Chandler@wellsfargo.com>
wrote:
>
> I'm working on a prototype Hitachi tablet, it uses a Fujitsu 4-wire 
> resistive touchscreen. {10.4" I think} I've found that windows-xp 
> embedded uses a generic ps/2 driver for the device.
>
> I've ripped this thing to pieces on several occasions looking for 
> chips to help the porting, my problem is that I can not find the 
> analog-digital converter for this thing.  The connector goes to a 
> surface mount header on an 8 layer board.
> I loose the traces almost instantly.  Given that I can't find the 
> converter anywhere what should I do next?
>
> I've done my homework and found that this HAS to be either serial or 
> usb attached according to Fujitsu.
> Aparently it's neither.  There are no unknown USB devices {or known 
> matching}, and there is no activity on the single serial port on the 
> system.  Since the windows driver uses PS/2 as the interface I have a 
> horrible feeling this thing has an interpretation layer that makes it 
> a
> PS/2 mouse, and that may or may not royally be a nightmare.
>

The touchscreen might need a "magic knock" to activate. You might try to
see what data wondows driver sends to PS/2 port.

Also check of Lifebook touchscreen protocol will work for you. You will
need to adjust DMI table in drivers/input/mouse/lifebook.c/

> I would have posted this to a different group but there is no "input"
> mailing list.
>

linux-input@atrey.karlin.mff.cuni.cz

But you must be subscribed to post otherwise list just drops your mails
on the floor.

--
Dmitry



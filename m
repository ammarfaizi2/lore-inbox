Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWGLWLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWGLWLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWGLWLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:11:05 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:38072 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S932467AbWGLWLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:11:01 -0400
Message-ID: <44B57373.2030907@dgreaves.com>
Date: Wed, 12 Jul 2006 23:10:59 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Mark Lord <liml@rtr.ca>,
       Jeff Garzik <jgarzik@pobox.com>, Sander <sander@humilis.net>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.17.3 (What is the next step?)
References: <Pine.LNX.4.64.0602140439580.3567@p34>	 <44AEB3CA.8080606@pobox.com>	 <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>	 <200607091224.31451.liml@rtr.ca>	 <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>	 <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>	 <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan>	 <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan>	 <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan>	 <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan>	 <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan>	 <1152545639.27368.137.camel@localhost.localdomain>	 <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan>	 <Pine.LNX.4.64.0607110926150.858@p34.internal.lan> <1152634324.18028.21.camel@localhost.localdomain>
In-Reply-To: <1152634324.18028.21.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-07-11 am 09:28 -0400, ysgrifennodd Justin Piszcz:
>> Alan/Jeff/Mark,
>>
>> Is there anything else I can do to further troubleshoot this problem now 
>> that we have the failed opcode(s)?  Again, there is never any corruption 
>> on these drives, so it is more of an annoyance than anything else.
> 
> Nothing strikes me so far other than the data not making sense. Possibly
> it will become clearer later if/when we see other examples.

For me it's SMART related.

smartctl -data -o on /dev/sda reliably gets a similar message.
Justin - does this smartctl command trigger a message for you?

I've been mailing on and off since January-ish.
(http://marc.theaimsgroup.com/?l=linux-ide&w=2&r=7&s=libpata&q=b)

Back in March I was running 2.6.16 (with a different version of Mark's
opcode patch) and I sent an email with the following info:

dmesg:
ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/04 to SCSI
SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }

Does that help with the diagnosis?

Also see my emails: SMART on SATA reporting errors?
  http://marc.theaimsgroup.com/?l=linux-ide&m=113933732903205&w=2

I did reply but got no response so I assumed I was just so far off base
that I was being ignored  :)

David

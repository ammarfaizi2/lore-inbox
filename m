Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWDLSd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWDLSd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 14:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWDLSd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 14:33:28 -0400
Received: from mail0.lsil.com ([147.145.40.20]:4761 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932314AbWDLSd2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 14:33:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: x86_86 SMP megaraid_mbox hangups and panics.
Date: Wed, 12 Apr 2006 12:33:23 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BCC6@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: x86_86 SMP megaraid_mbox hangups and panics.
Thread-Index: AcZeWhQG8DY5KEOvTmOpLEuQHkMGFgAAri2A
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "dormando" <dormando@rydia.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Apr 2006 18:33:21.0488 (UTC) FILETIME=[936C2500:01C65E5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wednesday, April 12, 2006 1:53 PM, Dormando  wrote:
> Can you confirm that you read my whole message? I might be a complete 
> idiot, but let me reiterate some highlights and add a few 
> more details 
> from my last mail:
> 
> If I build a 32-bit SMP OR 64-bit UP kernel, the cards will boot and 
> work *every time*.
Sorry, I've gone through but, ...

So far, the driver has been working on various x86_64 platforms (both AMD64 and EM64T with more than 4 GB mem.). Is this first time x86_64 kernel on those platforms or, the systems have been running on previous x86_64 kernels?
If you send me console log file, I'll look into it. But, still the issue need to be handled by SE team for further investigation.

I've submitted a patch that addresses one problem in 'megaraid_reset_handler()', but I don't think the fix connected to your issue directly.

Thank you,

Seokmann



> -----Original Message-----
> From: dormando [mailto:dormando@rydia.net] 
> Sent: Wednesday, April 12, 2006 1:53 PM
> To: Ju, Seokmann
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: x86_86 SMP megaraid_mbox hangups and panics.
> 
> Ju, Seokmann wrote:
> > Hi,
> >> Most of the time the server hits: "megaraid: probe new 
> device" - with 
> >> the device information, then hangs and starts the 180 second 
> >> countdown: 
> >> "megaraid: wait for FW to boot [blah]"
> >> After which I get a VFS panic for not having a root disk.
> > This means the controller is NOT taking any commands from 
> the driver at that time.
> > In other words, the F/W is NOT ready to take any command, yet.
> > It sounds like that the controller is NOT in good condition 
> for some reason and needs to check sanity of it.
> > You may want to check with LSI logic SE team.
> > 
> > Thank you,
> 
> Can you confirm that you read my whole message? I might be a complete 
> idiot, but let me reiterate some highlights and add a few 
> more details 
> from my last mail:
> 
> If I build a 32-bit SMP OR 64-bit UP kernel, the cards will boot and 
> work *every time*.
> 
> Most of the time this is a *kernel panic* in megaraid_ack_sequence, 
> somewhere through megaraid_isr in megaraid_mbox.c
> *Sometimes* it results in the firmware hanging like you 
> mentioned above.
> If I compile the drivers as modules instead of statically, this 
> *sometimes* results in the machine booting all the way. Once 
> the machine 
> boots up, I can give it a good 'ole I/O beatdown and it does 
> not flinch.
> 
> As in: I boot it once, it hangs. I reboot, it panics. I reboot, it 
> panics. I reboot, it works. I have 16 cards in 16 systems that all 
> exhibit the same behavior. Looks like an x86_64 SMP timing 
> issue of some 
> kind to me, and less of a card issue. Please correct me if I am wrong!
> 
> -Dormando
> 

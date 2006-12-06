Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937631AbWLFVCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937631AbWLFVCa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937638AbWLFVCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:02:30 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:44206 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937631AbWLFVCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:02:30 -0500
Date: Wed, 6 Dec 2006 22:00:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
In-Reply-To: <1165412195.5954.239.camel@titan.tbdnetworks.com>
Message-ID: <Pine.LNX.4.61.0612062158010.16042@yvahk01.tjqt.qr>
References: <1165405350.5954.213.camel@titan.tbdnetworks.com> 
 <1165406299.3233.436.camel@laptopd505.fenrus.org> 
 <1165407548.5954.224.camel@titan.tbdnetworks.com> 
 <1165409112.3233.441.camel@laptopd505.fenrus.org>
 <1165412195.5954.239.camel@titan.tbdnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 6 2006 14:36, Norbert Kiesel wrote:
>On Wed, 2006-12-06 at 13:45 +0100, Arjan van de Ven wrote:
>> On Wed, 2006-12-06 at 13:19 +0100, Norbert Kiesel wrote:
>> > On Wed, 2006-12-06 at 12:58 +0100, Arjan van de Ven wrote:
>> > > On Wed, 2006-12-06 at 12:42 +0100, Norbert Kiesel wrote:
>> > > > Hi,
>> > > > 
>> > > > I remember reading on LKML some time ago that using
>> > > > VMSPLIT_3G_OPT would be optimal for a machine with
>> > > > exactly 1GB memory (like my current desktop). Why is
>> > > > that option only prompted for after selecting EMBEDDED
>> > > > (which I normally don't select for desktop machines
>> > > 
>> > > because it changes the userspace ABI and has some other
>> > > caveats.... this is not something you should muck with
>> > > lightly
>> > 
>> > Hmm, but it's also marked EXPERIMENTAL. Would that not be
>> > the sufficient?  Assuming I don't use any external/binary
>> > drivers and a self-compiled kernel w//o any additional
>> > patches: is there really any downside?
>> 
>> I said *userspace ABI*. You're changing something that
>> userspace has known about and was documented since the start
>> of Linux. So userspace application binaries can break, and at
>> least you're changing the rules on them. That's fine if you
>> know what you're doing.. but in a general system... not a
>> good default, hence the EMBEDDED.
>
>Thanks for the reply. I was not asking to change the default, I
>just want to see the option in e.g. menuconfig. And the help
>text already has a very strong advise to leave it at
>VMSPLIT_3G.

I have not had yet any problems with VMSPLIT_3G_OPT ever since I
used it -- which dates back to when it was a feature of Con
Kolivas's patchset (known as LOWMEM1G), [even] before it got
merged in mainline.

It only seem to break the VMware compilation process, but what
they do in the makefiles is not really standard anyhow.

>Anyway, I don't want to stress this further: I'm happy enough with my
>Kconfig that has "if EMBEDDED" removed for the prompt. 



	-`J'
-- 

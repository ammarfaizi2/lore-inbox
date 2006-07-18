Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWGRDaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWGRDaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 23:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWGRDaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 23:30:22 -0400
Received: from xenotime.net ([66.160.160.81]:59299 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750781AbWGRDaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 23:30:22 -0400
Message-Id: <1153193418.25651@shark.he.net>
Date: Mon, 17 Jul 2006 20:30:18 -0700
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: Michael Krufky <mkrufky@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Axel Thimm <Axel.Thimm@atrpms.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: bttv-driver.c:3964: error: void value not ignored as it ought to be
X-Mailer: WebMail 1.25
X-IPAddress: 216.191.251.226
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Michael Krufky wrote:
> > Nish Aravamudan wrote:
> >> On 7/17/06, Michael Krufky <mkrufky@linuxtv.org> wrote:
> >>> Hmmm... This was caused by the "Check all __must_check warnings in
> >>> bttv." patch from Randy Dunlap (cc's from original thread added)
> >>>
> >>> I am aware that this was done for various reasons of sanity checking,
> >>> however, we cannot check the return value of a void ;-)
> >> For the sanity checking, I don't think video_device_create_file()
> >> should be a void function. It probably should return
> >> class_device_create_file()'s return value, no? As it can fail...
> >>
> > 
> > You are correct... I was merely pointing out the error, but now I see it
> > runs deeper than I had thought.  I will fix both
> > video_device_create_file and video_device_remove_file to return the
> > class_device_foo return values, then I'll push it over to Mauro.
> 
> I was in a rush when I wrote that, and I wasn't thinking. 
> video_device_remove_file stays as a void.
> 
> Anyway, here is the fix.  This is already in my tree ( 
> http://linuxtv.org/hg/~mkrufky/v4l-dvb ) but split into separate patches.

Hi,
Thanks for taking care of this.
I'll look over it and see what I missed.  Right now I have
terrible wireless connections/problems.  Sorry about the delay.

---
~Randy


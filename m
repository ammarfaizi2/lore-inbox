Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTKQJqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 04:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTKQJqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 04:46:12 -0500
Received: from main.gmane.org ([80.91.224.249]:17542 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263452AbTKQJqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 04:46:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Patrick Beard" <patrick@scotcomms.co.uk>
Subject: Re: 2.6.0-test9 VFAT problem
Date: Mon, 17 Nov 2003 09:46:38 -0000
Message-ID: <bpa5ct$qhm$1@sea.gmane.org>
References: <09A92EA4A9D2D51182170004AC96FE7A1216BB@mercury.scotcomms> <20031114190337.GA18107@win.tue.nl>
X-Complaints-To: usenet@sea.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, if sda1 works under 2.4, then sda is certainly wrong under 2.6 -
> your device would just look like garbage and the error messages are
> meaningless.
> Only try sda1, and report whatever goes wrong in that case.

Andries,
Thanks for your answer.
After what you and Philippe told me I wanted to do a sanity check on what
I'd done.

I don't leave my system on, and so when I have photos to get off the camera
I start the system insert my 64mb Olympus SM into my Belkin SM reader (USB)
mount it, and get the photos off of it. This explains why I've not run into
'Linux only checking the geometry on first connection' thing. As it turns
out sda1 does work on my system, even without your patch. However I can only
mount my 16mb Olympus SM card in my Belkin reader (something I rarely do).
If I try to mount my 64mb card I get 'no media found'. As I normally don't
use the 16mb card I think this problem together with the 'geometry checking'
led to my confusion of the problem. I say this as once I've tried to mount
the 64mb card in my reader and get the 'no media...', then Linux will report
this error for every card until the reader is disconnected and reconnected.

With that confusion now clarified in my own head here is what I know for
sure and can reproduce every time;

1. I am now using sda1 (sorry to the group for using sda and reporting this
as a problem).
2. I can mount both my 16mb and 64mb Olympus SM cards when using my Olympus
300-zoom camera as the reader.
3. I can mount the 16mb card when using my Belkin USB SM reader.
4. I cannot mount my 64mb card using the Belkin reader. Linux reports 'No
Media Found'.
5. I cannot mount my 16mb card in the Belkin reader after I've tried to
mount the 64mb card. However disconnecting and reconnecting the reader
allows me once again to mount the 16mb card.

Both smartmedia cards I have (16 & 64mb), are 'Olympus' branded and were
both formatted in the Olympus 300-zoom camera. I have reformatted both of
them but this didn't help.
Both cards worked in the Belkin reader when I was using the Debian 2.4.19
kernel source.

Philippe asked me to do a fdisk -l on /dev/sda He asked this when I reported
my first (non problem), and so this might not be relevant but here is what I
get back when I mount the 64mb using the camera (with the reader I obviously
don't get anything back);

/dev/sda1 * 1 500 63972+ 1 FAT12

Any advice would be appreciated.

__
Patrick






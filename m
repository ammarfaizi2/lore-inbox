Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUJLTFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUJLTFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUJLTFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:05:41 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:23767 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267536AbUJLTFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:05:34 -0400
Message-ID: <c25b25320410121205586f32f4@mail.gmail.com>
Date: Tue, 12 Oct 2004 12:05:34 -0700
From: Richard Hubbell <richard.hubbell@gmail.com>
Reply-To: Richard Hubbell <richard.hubbell@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sound problems in 2.6.8.1 w/ EMU10K1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled a 2.6.8.1 kernel and something has changed so that sound
works much differently.
At first I thought that it wasn't working at all, but with a bunch of
fiddling around I found I could get sound.  It's not clear to me if
this is an ALSA problem, kernel problem or both.  The first thing I
discovered was that with programs like xmms I had to change the device
to be hw:0,3 instead of the usual default of hw:0,0 .  Let's see if I
can provide some more context....

 All the devices look correct in /dev/snd/*, I use no modules but
rather compile all into the kernel.  Everything in /proc/asound looks
as it should.  (Of I never really had to look there
in previous kernels where sound was working).  The EMU10K1 (SBLive)
appears as card 0 and device 0 (as well as the other devices on that
card).  My ALSA lib versions match the kernel version.

My problems:

1.  default sound isn't working,  to make some apps work I created an
~/.asound file
     to specifiy the default to be  hw:0,3  (i.e. card0, device3 or pcmC0D3p)

2.  I can no longer play mono 8000 Hz sounds, attempting to do so hard locks
     the machine and requires a power cycle to recover.

I can provide more context if you think it will help.  Should this go
to ALSA instead?

Thanks in advance,
Richard

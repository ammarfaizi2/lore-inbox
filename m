Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSJQJgV>; Thu, 17 Oct 2002 05:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbSJQJgV>; Thu, 17 Oct 2002 05:36:21 -0400
Received: from [66.103.33.250] ([66.103.33.250]:52908 "EHLO spyke.sytes.net")
	by vger.kernel.org with ESMTP id <S261292AbSJQJgU>;
	Thu, 17 Oct 2002 05:36:20 -0400
Date: Thu, 17 Oct 2002 06:42:18 -0300
From: Spyke <spyke@spyke.sytes.net>
To: linux-kernel@vger.kernel.org
Subject: VIA82C686 Audio Problem.
Message-Id: <20021017064218.7ae4dda0.spyke@spyke.sytes.net>
Reply-To: spike@spyke.sytes.net
Organization: Linux
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello people,

I came across a rather annoying problem in the VIA82C686 southbridge audio driver. It will work ok, and then out of warning, go insane and completly lock the system up. It does seem to be rather random, theres no sound breakups or abnormalness, as if it was working perfectly.

Oct 13 22:45:40 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 13 22:49:59 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 13 22:54:26 spikes last message repeated 3 times
Oct 13 23:28:04 spikes last message repeated 6 times
Oct 13 23:34:35 spikes last message repeated 2 times
Oct 13 23:46:01 spikes last message repeated 2 times
Oct 13 23:46:02 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 01:20:11 spikes kernel: via82cxxx: timeout while reading AC97 codec (0x9A0000)
Oct 14 01:56:11 spikes kernel: via82cxxx: timeout while reading AC97 codec (0x9A0000)
Oct 14 02:47:31 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 02:47:32 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 18:55:35 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 18:59:18 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 19:06:02 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 19:09:14 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 19:15:42 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 19:31:42 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 19:41:40 spikes last message repeated 2 times
Oct 14 20:28:42 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 20:32:13 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 20:56:37 spikes kernel: Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,via_chan_maybe_start,line=1196
Oct 14 20:59:07 spikes last message repeated 4 times
<deadlock>
Oct 14 21:10:42 spikes syslogd 1.4.1: restart.

Its happened about 3 times since i started using this board, only while the sound is in use of course. Actually to be more precise, when it becomes idle after use, or sudden use. Any ideas?
Regards,

Brendan
spyke@spyke.sytes.net

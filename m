Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268019AbTBMLHh>; Thu, 13 Feb 2003 06:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268022AbTBMLHh>; Thu, 13 Feb 2003 06:07:37 -0500
Received: from pop017pub.verizon.net ([206.46.170.210]:49090 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S268019AbTBMLHf>; Thu, 13 Feb 2003 06:07:35 -0500
Date: Thu, 13 Feb 2003 22:18:02 +1100
From: Jonathan Thorpe <wd.dev@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: via8235 Audio on 2.4.21-pre
Message-Id: <20030213221802.09cd1afb.wd.dev@verizon.net>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at pop017.verizon.net from [144.136.115.9] at Thu, 13 Feb 2003 05:17:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

For the past two months, I've been testing Alan's updates to the
via82cxxx_audio driver which allow the codecs attached to the VT8235 to
work quite nicely. Recent updates have allowed the majority of
applications to work, however any version of ESD fails (whilst the same
configuration works fine with other sound drivers). 

This has been a problem ever since the first via82cxxx_audio releases with
vt8235 support, but at present, I'm using 2.4.21-pre4-ac4. When ESD is
loaded, 3 of the five beeps are heard (unless the beeps are disabled, in
which I can get about 0.25 seconds of audio to play through ESound) and
then ESound will hang. Once esound is killed, I get the message:

via_audio: ignoring drain playback error -512

This has been tested on several motherboards with different codecs - most
of which generally work well when using normal OSS applications. However,
the VT1612A (Subsystem: VIA Technologies, Inc.: Unknown device 4161) which
has a PCM2 volume control which behaves as the Master volume should; on
this chip, the Master volume doesn't do anything at all.

Are there any debugging modes that I can activate on this driver to
provide more valuable information? I'd really like to see this chip
working as ALSA has had less success than the OSS driver with a few codecs
attached to the VT8235.

Thanks,
Jonathan

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTFGBpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 21:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTFGBpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 21:45:47 -0400
Received: from xyzzy.bubble.org ([132.238.254.34]:55707 "EHLO xyzzy.bubble.org")
	by vger.kernel.org with ESMTP id S262489AbTFGBpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 21:45:44 -0400
Message-ID: <3EE146F6.8010709@bubble.org>
Date: Fri, 06 Jun 2003 21:59:18 -0400
From: Jeffrey Ross <jeff@bubble.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc7-ac1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I too am having problems with this sound driver on my system with this 
kernel release.

After booting the system, I found it would crash (blinking keyboard 
lights) within a few minutes of starting xwindows.  Upon seeing the 
notes about the AC'97 driver causing problems, I commented it out from 
the /etc/modules.conf and I have been stable (although mute) since.

The motherboard is an Intel D845GBV (uni-processor), and according to 
Intel the (built in) sound controller (quoted from the spec sheet 
http://www.intel.com/design/motherbd/bv/index.htm) "Audio subsystem for 
AC '97 processing using the Analog Devices AD1981A codec featuring 
SoundMAX Cadenza"

Although I don't have a copy of the oops message I'm sure if it would 
help I can set up a serial console to catch it.

The lines I had in the /etc/modules.conf (that I commented out) are:

alias sound-slot-0 i810_audio
alias sound-slot-0-0 i810_audio
alias char-major-14 i810_audio
alias sound-slot-1 btaudio
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S 
 >/dev/null 2>&1 || :


my .config file (for the sound) is:
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
CONFIG_SOUND_ICH=m
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
CONFIG_SOUND_TVMIXER=m


Let me know what else I can provide to help.

Jeff




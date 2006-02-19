Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWBSAdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWBSAdX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 19:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWBSAdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 19:33:23 -0500
Received: from secure.htb.at ([195.69.104.11]:26127 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S932372AbWBSAdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 19:33:22 -0500
Date: Sun, 19 Feb 2006 01:33:13 +0100
From: Richard Mittendorfer <delist@gmx.net>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No sound from SB live!
Message-Id: <20060219013313.17e91b04.delist@gmx.net>
In-Reply-To: <20060218234805.GA3235@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz>
	<200602190127.27862.ghrt@dial.kappa.ro>
	<20060218234805.GA3235@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FAcVn-0005zD-00*ksU0f94aZdg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Pavel Machek <pavel@suse.cz> (Sun, 19 Feb 2006 00:48:05
+0100):
> Hi!

Hello,

> I tried enabled everything I could in alsamixer, but still could not
> get it to produce some sound :-(.

I usually use some simple mixer like rexima and a small .wav or .ogg 
aplay/play/ogg123'ed for testing. 

Have one of those in a UP P3 here (but 2.6.15):

$ cat /proc/asound/cards
0 [Live ]: EMU10K1 - SBLive! Value [CT4670]
           SBLive! Value [CT4670] (rev.5, serial:0x201102) at 0xdc00,
irq 10

$ cat /proc/asound/devices 
  1:       : sequencer
  4: [0- 0]: hardware dependent
  8: [0- 0]: raw midi
 19: [0- 3]: digital audio playback
 18: [0- 2]: digital audio playback
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
  6: [0- 2]: hardware dependent
  9: [0- 1]: raw midi
 10: [0- 2]: raw midi
 33:       : timer

# lsmod    [sound]
emu10k1_gp              1152  0 
snd_emu10k1_synth       4160  0 
snd_emux_synth         26048  1 snd_emu10k1_synth
snd_seq_virmidi         2976  1 snd_emux_synth
snd_seq_midi_emul       4224  1 snd_emux_synth
snd_emu10k1            89284  1 snd_emu10k1_synth
snd_rawmidi            13344  2 snd_seq_virmidi,snd_emu10k1
snd_ac97_codec         69344  1 snd_emu10k1
snd_ac97_bus             768  1 snd_ac97_codec
snd_util_mem            1312  2 snd_emux_synth,snd_emu10k1
snd_hwdep               4320  2 snd_emux_synth,snd_emu10k1

Any message when you try to play a file? Or just no sound output, but
progress while playing? 

sl ritch

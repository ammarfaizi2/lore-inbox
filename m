Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWCLILS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWCLILS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 03:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWCLILS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 03:11:18 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:24453 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751344AbWCLILR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 03:11:17 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*
Date: Sun, 12 Mar 2006 03:11:09 -0500
User-Agent: KMail/1.9.1
Cc: Otavio Salvador <otavio@debian.org>, Adrian Bunk <bunk@stusta.de>,
       "S. Umar" <umar@compsci.cas.vanderbilt.edu>,
       linux-kernel@vger.kernel.org
References: <200602270900.13654.umar@compsci.cas.vanderbilt.edu> <878xrnczql.fsf@nurf.casa> <s5hr75fley8.wl%tiwai@suse.de>
In-Reply-To: <s5hr75fley8.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603120311.09105.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 11:23, Takashi Iwai wrote:
> At Mon, 06 Mar 2006 13:19:30 -0300,
>
> Otavio Salvador wrote:
> > Takashi Iwai <tiwai@suse.de> writes:
> > >> Shouldn't this fix go into 2.6.16?
> > >
> > > Unfortunately it's involved with many other patches (especially
> > > semahpore->mutex ones) and hard to cherry-pick...
> >
> > I could prepare another patch just to fix it and then put it in on
> > 2.6.16.

I have a DELL E1705 Laptop and snd-intel-hda used to work for me in 2.6.15 - 
it no longer works (Silence, no sound, no errors in dmesg) with 2.6.16-rc6. 

I have tried to load snd_hda_intel with  model=basic but even then it did not 
work for me. 

cat /proc/asound/cards
 0 [01cd           ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xdfebc000 irq 233
 cat /proc/asound/01cd/
codec#0    codec#1    id         oss_mixer  pcm0c/     pcm0p/     pcm1p/
paragw@penguin ~ $ cat /proc/asound/01cd/codec#0
Codec: SigmaTel STAC9200
Address: 0
Vendor Id: 0x83847690
Subsystem Id: 0x102801cd
Revision Id: 0x102201
Default PCM: rates 0x7e0, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
Node 0x02 [Audio Output] wcaps 0xd0401: Stereo
  Power: 0x0
Node 0x03 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x0a
Node 0x04 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM: rates 0x160, bits 0x0e, types 0x5
  Connection: 1
     0x08
Node 0x05 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM: rates 0x1e0, bits 0x0e, types 0x5
Node 0x06 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x07 [Audio Selector] wcaps 0x300901: Stereo
  Connection: 3
     0x02* 0x08 0x0a
Node 0x08 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN
  Pin Default 0x40c003fa: [N/A] SPDIF In at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x09 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x01441340: [Jack] SPDIF Out at Ext Rear
    Conn = RCA, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 2
     0x05* 0x0a
Node 0x0a [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x0c
Node 0x0b [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x9f 0x9f]
  Connection: 1
     0x07
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 5
     0x10* 0x0f 0x0e 0x0d 0x12
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP
  Pin Default 0x0421421f: [Jack] HP Out at Ext Right
    Conn = 1/8, Color = Green
  Pin-ctls: 0x00:
  Connection: 1
     0x0b
Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP
  Pin Default 0x90170310: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x0b
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT
  Pin Default 0x408003fb: [N/A] Line In at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0b
Node 0x10 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT
  Pin Default 0x04a1102e: [Jack] Mic at Ext Right
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0b
Node 0x11 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x90170311: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x13
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x403003fc: [N/A] CD at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x13 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x07
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]

cat /proc/asound/01cd/codec#1
Codec: Generic 14f1 ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x14f100c3
Revision Id: 0x90000


Parag

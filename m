Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbTEJPSf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTEJPSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:18:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:25040 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264373AbTEJPSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:18:13 -0400
Date: Sat, 10 May 2003 17:28:31 +0200
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <S264332AbTEJO5e/20030510145734Z+7011@vger.kernel.org>
References: <1405.1052575075@www9.gmx.net>
	<1052575167.16165.0.camel@dhcp22.swansea.linux.org.uk>
	<S264332AbTEJO5e/20030510145734Z+7011@vger.kernel.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <S264373AbTEJPSN/20030510151813Z+1648@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003 17:07:51 +0200
Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de> wrote:

> On 10 May 2003 14:59:31 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > On Sad, 2003-05-10 at 14:57, Tuncer M zayamut Ayaz wrote:
> > > description of the strange sound: 
> > >   - high tone 
> > >   - permanent 
> > >   - happens before loading ALSA modules 
> > 
> > What happens if you mute the microphone and line in ?
> 
> how to do that prior to booting up the kernel?
> if I should do it later (after module loading, maybe on
> amixer init) I'd have to consult amixer manuals
> to see how that works first...

hmm according to alsamixer everything is "ZERO".
see asound.state below.

what I found out right now is that when there is
load (moving mailer windows around) the sound
is gone and reappears if there's no load aka
I stop moving mailer window (while typing this mail).

state.Dummy {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Master Volume'
		value.0 0
		value.1 0
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Capture Switch'
		value.0 false
		value.1 false
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Synth Volume'
		value.0 0
		value.1 0
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Synth Capture Switch'
		value.0 false
		value.1 false
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Line Volume'
		value.0 0
		value.1 0
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Capture Switch'
		value.0 false
		value.1 false
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Mic Volume'
		value.0 0
		value.1 0
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Capture Switch'
		value.0 false
		value.1 false
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'CD Volume'
		value.0 52
		value.1 52
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Capture Switch'
		value.0 false
		value.1 false
	}
}
state.VirMIDI {
}
state.PCI {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value false
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 0
		value.1 0
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value false
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 0
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value false
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 0
		value.1 0
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value false
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value false
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 0
		value.1 0
	}
	control.22 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 Mic
		value.1 Mic
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.26 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.27 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 3'
		iface MIXER
		name '3D Control Sigmatel - Depth'
		value 0
	}
	control.29 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier Power Down'
		value false
	}
}

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267247AbTAKO7z>; Sat, 11 Jan 2003 09:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbTAKO7z>; Sat, 11 Jan 2003 09:59:55 -0500
Received: from mail.broadpark.no ([217.13.4.2]:38084 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S267247AbTAKO7w>;
	Sat, 11 Jan 2003 09:59:52 -0500
Message-ID: <3E20338A.5182057@online.no>
Date: Sat, 11 Jan 2003 16:08:58 +0100
From: Knut J Bjuland <knutjbj@online.no>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.18-18SGI_XFS_1.2pre4custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug in genrate-modprobe.conf
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

genrate-modprobe is unable to convert my modules.conf.  Which is below.
Please cc: me. The problem is that the converting script does not
produce a modprobe.conf at all.  I am running this script as root booted
into linux 2.5.54 in init mode 1.

alias parport_lowlevel parport_pc
alias usb-controller usb-uhci
alias eth0 3c59x


# #alsa
alias char-major-116 snd
alias snd-card-0 snd-emu10k1
#options snd snd_cards_limit=1
##oss lite
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
##oss service
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
post-install snd-emu10k1-synth sfxload /etc/midi/8mbgmsfx.sf2;
/usr/sbin/alsactl restore


# alsa finsihed
options ide-cd dma=1

# bttv
#alias char-major-81 videodev
alias char-major-81  bttv

# BTTV setup by JeMi - 8/Dec/2000
options bttv pll=1 radio=0 card=39
options tuner type=5
post-install bttv /sbin/modprobe "-k" tuner;
                   /sbin/modprobe "-k" msp3400

#nvidia

alias char-major-195 nvidia



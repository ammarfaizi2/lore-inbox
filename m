Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWBSVyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWBSVyl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWBSVyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:54:41 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:22717 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751021AbWBSVyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:54:40 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, tiwai@suse.de, ghrt@dial.kappa.ro,
       perex@suse.cz, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060219214934.GO15311@elf.ucw.cz>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com>
	 <7c3341450602190318o1c60e9b5w@mail.gmail.com>
	 <20060219205157.GA5976@us.ibm.com> <1140384638.2733.389.camel@mindpipe>
	 <20060219214934.GO15311@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 16:54:34 -0500
Message-Id: <1140386075.2733.399.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 22:49 +0100, Pavel Machek wrote:
> Hi!
> 
> > > I run Ubuntu Breezy, which has:
> > > 
> > > alsa-utils = 1.0.9a-4ubuntu5 
> > 
> > The alsa-utils version should not matter, it's alsa-lib that must be
> > kept in sync with the ALSA version in the kernel.
> 
> I tried to play with mpg123 using OSS emulation, so that it does not
> have anything to do with ALSA. No luck. Trying aplay:
> 
> root@hobit:/dev/snd#  aplay
> /usr/share/xemacs21/xemacs-packages/etc/sounds/hammer.wav
> aplay: main:533: audio open error: No such file or directory
> 
> while stracing:
> 
> open("/dev/snd/pcmC0D0p", O_RDWR)       = -1 ENOENT (No such file or
> directory)
> close(3)                                = 0
> write(2, "aplay: main:533: ", 17aplay: main:533: )       = 17
> write(2, "audio open error: No such file o"..., 43audio open error: No
> such file or directory) = 43
> write(2, "\n", 1
> 
> ... but pcmC0D0p is not described in devices.txt...?

Hmm, that's a udev problem or something.  If you have a static dev the
snddevices script that comes with ALSA will create the device files.

Lee


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282671AbRLRKSM>; Tue, 18 Dec 2001 05:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285633AbRLRKSD>; Tue, 18 Dec 2001 05:18:03 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:17889 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S282671AbRLRKR6>; Tue, 18 Dec 2001 05:17:58 -0500
Date: Tue, 18 Dec 2001 11:17:54 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: compile problem: es1371+gamepad
In-Reply-To: <20011217220240.A21215@suse.cz>
Message-ID: <Pine.NEB.4.43.0112181110450.7950-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Vojtech Pavlik wrote:

> > The patch below should hadle this problem better.
> >
> > I've found another problem:
> > When I do completely disable "Input core support" after it was compiled
> > into the kernel and I go to the "Sound" menu the implicite change that
> > CONFIG_INPUT_GAMEPORT is automatically turned off wasn't done. It seems I
> > need to either go to the "Joysticks" menu or to quit "make menuconfig" to
> > get the wanted effect in the "Sound" submenu. Is this a bug or a known
> > limitation of "make menuconfig"?
>
> It really can be solved sufficiently with CML2.  Other than that, there
> are always combinations which are either causing compile errors or are
> possible but not allowed by the menuconfig.

Yes, it's clear to me that these problems won't occur in CML2 but it's
unlikely that CML2 will make it into the 2.4 kernels, so we need
workarounds that work in most cases.

The workaround you invented doesn't work in the case when
CONFIG_INPUT_GAMEPORT is compiled modular.

My patch handles these cases, too. If you do the wrong things in the wrong
order (not that extremely likely) the things that are displayed aren't
100% correct, but at least you do always have a valid configuration in the
end.

IMHO your solution is nearer on how it should be implemented in CML2 and
my solution is a better workaround for the limited CML1.

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400



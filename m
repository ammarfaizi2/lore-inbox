Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVAERZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVAERZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVAERZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:25:06 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14746 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262287AbVAERYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:24:35 -0500
Subject: Re: [Alsa-devel] Re: 2.6.10-mm1: ALSA ac97 compile error with
	CONFIG_PM=n
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark_H_Johnson@raytheon.com, Takashi Iwai <tiwai@suse.de>,
       Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org,
       Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>,
       perex@suse.cz
In-Reply-To: <1104936968.24187.180.camel@localhost.localdomain>
References: <OFB0B3CD59.F6AC2867-ON86256F80.004CECD3@raytheon.com>
	 <1104936968.24187.180.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 12:23:51 -0500
Message-Id: <1104945831.8589.25.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 14:56 +0000, Alan Cox wrote:
> On Mer, 2005-01-05 at 14:21, Mark_H_Johnson@raytheon.com wrote:
> > > The default blocking behavior of OSS devices was changed recently.
> > > When the device is in use, open returns -EBUSY immediately in the
> > > latest version while it was blocked until released in the former
> > > version.
> > I suppose there was a "good reason" for changing the user level
> > interface in this way. Could you [or someone else] explain that and
> > if you would consider changing it back (to stop breaking old applications)?
> > Otherwise - is there some way (other than running lsmod and grep) to find
> > out if the interface is busy and which application is using it?
> 
> OSS itself changed behaviour over time (2.2 to 2.4) ALSA has merely
> caught up with the newer OSS behaviour and the new behaviour is correct.
> 
> If you want to find out if the interface is busy open it. If you want to
> do it portably open it with O_NDELAY.
> 

And if you want to find out who is using it then try fuser /dev/dsp,
fuser /dev/snd/*, or lsof.

Lee


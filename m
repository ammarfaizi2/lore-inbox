Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbTFSLRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 07:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265769AbTFSLRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 07:17:12 -0400
Received: from gate.perex.cz ([194.212.165.105]:52741 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S265768AbTFSLRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 07:17:09 -0400
Date: Thu, 19 Jun 2003 13:30:53 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Frank Victor Fischer <celestar@t-online.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: alsa sound module on 2.5.72 --- does not create /dev/snd/controlC0
In-Reply-To: <1056017227.3327.76.camel@darkstar.fischer.homeip.net>
Message-ID: <Pine.LNX.4.44.0306191327200.1930-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jun 2003, Frank Victor Fischer wrote:

> Hello out there
> 
> I have just switched from 2.5.70 to 2.5.72 on my test box, and found
> that I have problems using the mixer for emu10k1, with both alsamixer
> and amixer. Using 2.5.71 hit the same problem.
> 
> Next, I have used the 2.5.70 source tree for the 2.5.72 build, but the
> problem persists.
> 
> I have then straced the command "amixer set Master 50 unmute" on both
> 2.5.70 and 2.5.72, which revealed that on .72 /dev/snd/controlC0 is not
> created (the mixer program cannot open it), because /dev/snd is a
> symbolic link to /proc/asound/dev which does not exist.
> 
> What am I missing?

You need to rerun the snddevices scripts (distributed in the alsa-driver
package) or use devfs. The dynamic devices in the proc filesystem were
removed on request to clean up the ALSA code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVAETvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVAETvt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVAETvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:51:49 -0500
Received: from dfw-gate2.raytheon.com ([199.46.199.231]:5432 "EHLO
	dfw-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S262139AbVAETvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:51:47 -0500
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org,
       Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>,
       perex@suse.cz
From: Mark_H_Johnson@raytheon.com
Subject: Re: [Alsa-devel] Re: 2.6.10-mm1: ALSA ac97 compile error with CONFIG_PM=n
Date: Wed, 5 Jan 2005 12:15:50 -0600
Message-ID: <OF26B98961.8FD70ADB-ON86256F80.00645396-86256F80.006453DD@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/05/2005 12:17:19 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At Wed, 5 Jan 2005 08:21:20 -0600,
> Mark_H_Johnson@raytheon.com wrote:
[snip - back & forth on the blocking behavior]
> > I suppose there was a "good reason" for changing the user level
> > interface in this way. Could you [or someone else] explain that and
> > if you would consider changing it back (to stop breaking old
applications)?
>
> It was discussed on alsa-devel in November.  Unfortunately, I can't
> find ML archive any longer...
>
> The blocking behavior of OSS is a feature which is nowehre defined.
> Some OSS drivers open in the blocking mode and some don't.
> So, apps shouldn't depend on this feature.
>
> We had implemented OSS emulation in the blocking manner since we
> intepreted the POSIX definition in that way.  But Linus pointed out
> that it's a misreading.
>
> BTW, you can enable the blocking mode again via module/boot option.
> See OSS-Emulation.txt.
>
Thanks for the explanation and the suggested work around. Thanks
also to Lee Revell for his other suggestion (using fuser). I should
be able to work around this OK for now.

> > > [snip - rehash of symptoms]
> Please provide the hardware details (I don't see your original post to
> lkml).  Otherwise it'll be a vapor discusson...

Details provided separately. Basically it is a two CPU system (866 Mhz
Pentium III) with an Ensoniq sound card. I use this system primarily
for comparative tests of kernels (for RT latency) before moving a
kernel update to other system for more comprehensive tests.

  --Mark


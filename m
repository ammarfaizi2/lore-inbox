Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWGAOGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWGAOGf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 10:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWGAOGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 10:06:34 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47331 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751228AbWGAOGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 10:06:33 -0400
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
From: Lee Revell <rlrevell@joe-job.com>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Olivier Galibert <galibert@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz,
       Olaf Hering <olh@suse.de>
In-Reply-To: <44A6279C.3000100@superbug.co.uk>
References: <20060629192128.GE19712@stusta.de>
	 <44A54D8E.3000002@superbug.co.uk> <20060630163114.GA12874@dspnet.fr.eu.org>
	 <1151702966.32444.57.camel@mindpipe>
	 <20060701073133.GA99126@dspnet.fr.eu.org> <44A6279C.3000100@superbug.co.uk>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 09:52:40 -0400
Message-Id: <1151761961.11897.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-01 at 08:43 +0100, James Courtier-Dutton wrote:
> Olivier Galibert wrote:
> > On Fri, Jun 30, 2006 at 05:29:26PM -0400, Lee Revell wrote:
> >> Even if you reject this argument, the bug is in ALSA's in-kernel OSS
> >> emulation, not the emu10k1 driver.
> > 
> > That's irrelevant.  You can't remove the oss emu10k1 driver in favor
> > of alsa's until alsa provides an equivalent interface.  That's a basic
> > compatibility requirement.
> > 
> > 
> >> ALSA's in-kernel OSS emulation does not have these features and
> >> never will.
> > 
> > "Never" is terribly long.
> > 
> >   OG.
> 
> "Never" probably only means terribly long. :-)
> 
> If one takes the ALSA todo list, that is massive (it is so long in fact,
> that we have not had time to write it all down!), sort it by priority,
> then divide by the amount of ALSA developers time available, for this
> particular feature, the time to implementation is getting very close to
> "Never".

The reason I say "never" is because it would either require moving
alsa-lib into the kernel (long ago rejected), or devising some system to
redirect operations on /dev/dsp back into userspace to alsa-lib.  It
seems insane for the audio path to be
userspace->kernel->userspace->kernel and I'm pretty sure this idea was
also rejected a while back.

Lee


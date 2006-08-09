Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWHIVWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWHIVWG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWHIVWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:22:06 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:32530 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751351AbWHIVWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:22:04 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ALSA problems with 2.6.18-rc3
Date: Wed, 9 Aug 2006 22:22:05 +0100
User-Agent: KMail/1.9.4
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Andrew Benton <b3nt@ukonline.co.uk>, Takashi Iwai <tiwai@suse.de>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
References: <44D8F3E5.5020508@ukonline.co.uk> <200608091651.28077.gene.heskett@verizon.net> <1155157036.26338.200.camel@mindpipe>
In-Reply-To: <1155157036.26338.200.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608092222.05993.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 21:57, Lee Revell wrote:
> On Wed, 2006-08-09 at 16:51 -0400, Gene Heskett wrote:
[snip]
> > I already have the 'alsactl restore' in my rc.local.  Would there be any
> > harm in just adding the -F to that invocation, or will that just restore
> > it to a 'default' condition always.  Seems like it would, canceling
> > anything you have done & then did an 'alsactl store' to save..
>
> That's what I was suggesting - just add -F to the alsactl restore in
> your init script.  It won't restore it to a default state - the only
> difference is that it will do a better job restoring your mixer state if
> new controls are added by a driver update.
>
> alsactl --help:
>
>   -F,--force      try to restore the matching controls as much as
> possible

I assume there are drawbacks to such an option, since whatever method is used 
to "force" the control may make a mistake if similarly named controls are 
renamed.

Personally, I think the correct approach would be to have more sensible 
default values. Having the External Amplifier default off when it cripples 
analogue output on emu10k1, and has no effect on digital output, seems rather 
weird. Also, I never really understood the rationale for the "all zeros" 
mixer default. Why not 50%?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

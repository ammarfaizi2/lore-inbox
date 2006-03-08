Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWCHRz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWCHRz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbWCHRz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:55:28 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:62119 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751822AbWCHRz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:55:26 -0500
Subject: Re: [Alsa-devel] Re: 2.6.15-rt18, alsa sequencer, rosegarden ->
	alsa hangs
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, karsten wiese <annabellesgarden@yahoo.de>,
       Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net, cc@ccrma.Stanford.EDU
In-Reply-To: <20060308140635.GA16972@elte.hu>
References: <1141800836.6150.3.camel@cmn3.stanford.edu>
	 <20060308133635.96547.qmail@web26507.mail.ukl.yahoo.com>
	 <20060308140635.GA16972@elte.hu>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 09:54:59 -0800
Message-Id: <1141840499.5262.8.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 15:06 +0100, Ingo Molnar wrote:
> * karsten wiese <annabellesgarden@yahoo.de> wrote:
> 
> > ALSA Midi sequencer uses tasklets. there are 2 kinds of
> > them: lo and hi.
> > In rt-18 PREEMPT-RT, tasklet_hi_schedule() didn't work,
> > 'cause it woke up tasklet_lo's thread.
> > Thats what my patch fixed.
> 
> ah - i thought that -rt18 had your fix already - but indeed it's -rt19 
> that added it. So it's probably the same bug.

I agree, I just booted into -rt20 and the problem seems to be gone. Let
me know if you still want the trace, I can always boot again into the
buggy kernel. 

Thanks for the help!
-- Fernando



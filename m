Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWCHGyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWCHGyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 01:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWCHGyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 01:54:11 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:62927 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S1751050AbWCHGyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 01:54:09 -0500
Subject: Re: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       alsa-devel@lists.sourceforge.net, cc@ccrma.Stanford.EDU
In-Reply-To: <20060307220628.GA27536@elte.hu>
References: <1141769000.5565.21.camel@cmn3.stanford.edu>
	 <20060307220628.GA27536@elte.hu>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 22:53:55 -0800
Message-Id: <1141800836.6150.3.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 23:06 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > The symptoms are as follows:
> >   - start jack using qjackctl
> >   - start qsynth (gui front end for fluidsynth, a synth)
> >   - start rosegarden (midi sequencer and audio recorder)
> >   - load a midi file into rosegarden
> >   - midi file plays successfully
> >   - close rosegarden
> > at this point one of the threads of rosegarden fails to exit and stays
> > forever in the process list, in a ps axuw it shows as:
> > 
> > nando 5484 0.0 0.0 0 0 pts/1    D    13:32   0:00 [rosegardenseque]
> > 
> > Anything else that I try to stop that touches the alsa sequencer never
> > dies (qjackctl, vkeybd, qsynth, etc). Anything I try to start that tries
> > to use it does not start. This happened with two widely different
> 
> could you get a tasklist-dump? It's either SysRq-T, or:
> 
> 	echo t > /proc/sysrq-trigger
> 
> that should dump all tasks and their backtraces - including the hung 
> rosegardensequencer task.

I'll try to do that tomorrow. 

In the meanwhile I think this might be the same problem that was solved
in -rt20? (building it as I type). I have been trying to catch up to the
subset of lkml that I manage to read and found some reports that
apparently point to similar problems with the alsa sequencer (Rui, in
particular, and then Karsten's post in this thread).

-- Fernando



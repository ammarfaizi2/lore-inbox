Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317769AbSFLTZR>; Wed, 12 Jun 2002 15:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317770AbSFLTZQ>; Wed, 12 Jun 2002 15:25:16 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:9226 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S317769AbSFLTZP>; Wed, 12 Jun 2002 15:25:15 -0400
Date: Wed, 12 Jun 2002 20:37:03 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Robert Love <rml@tech9.net>, Helge Hafting <helgehaf@aitel.hist.no>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scheduler hints
Message-ID: <20020612203703.F22429@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <1023206034.912.89.camel@sinai> <3CFDC796.C05FC7E2@aitel.hist.no> <1023293838.917.283.camel@sinai> <20020607113231.GA133@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2002 at 01:32:31PM +0200, Pavel Machek wrote:
> > Boosting its priority will assure there is no priority inversion and
> > that, eventually, the task will run - but it does nothing to avoid the
> > nasty "grab resource, be preempted, reschedule a bunch, finally find
> > yourself running again since everyone else blocked" issue.
> > 
> > And I don't think only root should be able to do this.  If we later
> > punish the task (take back the timeslice we gave it) then this is
> > fair.
> 
> Another possibility might be to allow it to *steal* time from another
> processes... Of course only processes of same UID ;-).
> 									Pavel

Good idea! 

And I would say SID instead of UID and give up, if no task in the
same SID is runnable. 

One could provide different policies here, which the user can
choose/combine.

That way we aren't at least unfair to other users on our remote
machine.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

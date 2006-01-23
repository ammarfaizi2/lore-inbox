Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWAWU7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWAWU7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWAWU7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:59:43 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5034 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964873AbWAWU7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:59:42 -0500
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and
	2.6.16-rc1-mm1
From: Lee Revell <rlrevell@joe-job.com>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <20060123215231.04b38886@localhost>
References: <43D00887.6010409@bigpond.net.au>
	 <20060121114616.4a906b4f@localhost> <43D2BE83.1020200@bigpond.net.au>
	 <20060123210918.54d4fc75@localhost> <1138047938.21481.11.camel@mindpipe>
	 <20060123215231.04b38886@localhost>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 15:59:38 -0500
Message-Id: <1138049979.21481.25.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 21:52 +0100, Paolo Ornati wrote:
> On Mon, 23 Jan 2006 15:25:37 -0500
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > This seems right to me, how do you expect X to be treated by the
> > scheduler?
> 
> Why moving the mouse a little (that causes a microscopic % of CPU
> being used) makes X priority jump up to 29 from 6/7 ???

> And why this doesn't happen when glxgears (for example) is running?
> (under cpu load this is different, with X never getting "good"
> priority -- if I remember correctly)
> 
> Maybe this is normal and depends on the way X sleeps or something...
> 

Because the scheduler favors interactive tasks (aka those which spend a
large % of time waiting on external events) and X is only considered
interactive when the mouse is being moved.  When glxgears is running
it's CPU bound and is therefore penalized.

> I don't know much about schedulers but if I'm able to make the cursor
> going in jerks with just a bit of CPU load (linux$ make -j16, for
> example) I wonder why X cannot get a better priority...
> 

Personally I don't see how we can expect to deliver OSX-caliber
multimedia performance using only generalized heuristics in the
scheduler (other OSes use hooks into the scheduler for multimedia).  At
the very least it seems you need isochronous scheduling and a
multi-threaded X server.

Lee


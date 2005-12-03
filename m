Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVLCXs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVLCXs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 18:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVLCXs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 18:48:29 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:51076 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S932176AbVLCXs3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 18:48:29 -0500
Subject: Re: 2.6.14-rt21 & evolution
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1133647737.5890.2.camel@mindpipe>
References: <1133642866.16477.11.camel@cmn3.stanford.edu>
	 <1133647737.5890.2.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 15:48:16 -0800
Message-Id: <1133653696.16477.47.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 17:08 -0500, Lee Revell wrote:
> On Sat, 2005-12-03 at 12:47 -0800, Fernando Lopez-Lezcano wrote:
> > Hi Ingo... just a heads up. I've been running 2.6.14-rt21 for a few days
> > and the timing issues seem to be gone on my X2 machine, as the main
> > timing is no longer derived from the TSC's. Very good! It should work
> > great with a patched Jack (that does not use TSC for its internal timing
> > measurements). 
> > 
> > But I'm seeing a recurrent problem that so far I can only blame -rt21
> > for. When I start evolution (on a fully patched 32 bit fc4 system) it
> > eventually dies.
> 
> I was seeing exactly the same problem here.  I don't think it's related
> to -rt21, I think someome posted a malformed message to LKML or one of
> the other lists that we are both on and Evo is choking on it.  It starts
> to download the mail then you get "Storing folder" for like 5 minutes
> then it crashes.

It is not the exact same behavior I'm seeing, I get the crashes usually
in the middle of the new message download process the first time I start
evo in the morning. If I let it idle after startup, evo does all the
"storing folder" stuff and eventually dies when getting the new email
(or so I think). 

But you could of course be right and there is some message it is choking
on - it is strange that this is happening to you as well. I think this
first happened to me on Wed Nov 30. 

To tell the truth this does not seem like a -rt related problem except
that it started happening the day I booted into -rt21. 

> I finally managed to get into my mail by (carefully) deleting ALL
> metadata - all the .index, .index.data, .cmeta, and .ev-summary files
> from .evolution.

I can get it to start after two or three tries (so far) without touching
anything in evo's files. And then it runs fine. The behavior
_subjectively_ gives me the impression that it is related to downloading
large number of messages, or doing many things at once at startup
(threading). 

-- Fernando



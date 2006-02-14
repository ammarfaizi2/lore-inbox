Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWBNMeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWBNMeM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWBNMeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:34:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:62675 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161027AbWBNMeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:34:11 -0500
Date: Tue, 14 Feb 2006 13:32:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [PATCH 00/12] hrtimer patches
Message-ID: <20060214123226.GA3138@elte.hu>
References: <Pine.LNX.4.61.0602141057320.30994@scrub.home> <20060214110947.GA25341@elte.hu> <Pine.LNX.4.61.0602141228120.30994@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602141228120.30994@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > Here is new version of the hrtimer patches sorted by priority. I 
> > > dropped the remaining time patch, the const patch doesn't produce a 
> > > larger kernel with gcc3 and I also added the acks so far. I consider 
> > > the first four patches the most important and the remaining patches 
> > > simple enough, that I think they're still 2.6.16 material.
> > 
> > i only consider the first two patches to be 2.6.16 material. The other 
> > patches avoid a ->get_time() call per timer interrupt - that's noise at 
> > most ...
> 
> It's two get_time() calls and I don't consider it noise, they are 
> wasting time with unnecessary hardware accesses.

Nobody complained about it so far (other than you) or has measured it, 
so IMO there's no pressing need and it's simply too late in the cycle to 
touch core timer code like that. 2.6.16 is really cooling down now.

Furthermore, this is known subtle code, and it has accumulated some good 
QA by now. Your first patch-queue already introduced races (the 
"optimize hrtimer_get_remaining" patch) - which you considered to be
part of the "minimum amount of patches for 2.6.16" too.

Dont take this as some negative feedback: most of them look fine to me,
and it's really great that you are contributing to the code, but please
be a bit more patient.

	Ingo

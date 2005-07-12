Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVGLEaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVGLEaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 00:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVGLEaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 00:30:35 -0400
Received: from dvhart.com ([64.146.134.43]:10678 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262336AbVGLEad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 00:30:33 -0400
Date: Mon, 11 Jul 2005 21:30:33 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Friesen <cfriesen@nortel.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <188690000.1121142633@[10.10.2.4]>
In-Reply-To: <1121141602.2632.31.camel@mindpipe>
References: <200506231828.j5NISlCe020350@hera.kernel.org> <20050708214908.GA31225@taniwha.stupidest.org> <20050708145953.0b2d8030.akpm@osdl.org> <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe> <20050709203920.394e970d.diegocg@gmail.com> <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay> <1121113532.2383.6.camel@mindpipe>  <42D2D912.3090505@nortel.com> <1121128260.2632.12.camel@mindpipe>  <165840000.1121141256@[10.10.2.4]> <1121141602.2632.31.camel@mindpipe>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Lee Revell <rlrevell@joe-job.com> wrote (on Tuesday, July 12, 2005 00:13:21 -0400):

> On Mon, 2005-07-11 at 21:07 -0700, Martin J. Bligh wrote:
>> 
>> --Lee Revell <rlrevell@joe-job.com> wrote (on Monday, July 11, 2005 20:30:59 -0400):
>> 
>> > On Mon, 2005-07-11 at 14:39 -0600, Chris Friesen wrote:
>> >> Lee Revell wrote:
>> >> 
>> >> > Tickless + sub HZ timers is a win for everyone, the multimedia people
>> >> > get better latency, and the laptop people get to run longer.
>> >> 
>> >> IIRC it's not a win for many systems.  Throughput goes down due to timer 
>> >> manipulation overhead.
>> > 
>> > Makes sense.  Anyway, this whole thread has been pretty hand wavey, I
>> > propose that until we see some numbers from the HZ=250 advocates, we
>> > leave the default alone.
>> 
>> Odd. Since I showed you some numbers already ... and nobody from the latency
>> side of the argument has come up with any?
> 
> Sorry, I have not seen any.  Got a link?

Look back in the thread. It made kernel compiles about 5% faster on a
fairly large box. I think the SGI people did it originally because it
caused them even larger problems.

I'm not saying their aren't arguments on both sides ... there are. I just
agree with you there's a lot of hand-waving going on ... but probably not
agreeing as to who it's coming from ;-)

Some sort of comprimise has to be struck for now, until we get sub-HZ
timers. I'd prefer 100, personally (I had that set as default in my tree
for a long time). Some people would prefer 1000 or even more, maybe.
250/300 seems like a reasonable comprimise to me. Exactly what problems
*does* it cause (in visible effect, not "timers are less granular").
Jittery audio/video? How much worse is it?

M.


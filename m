Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVEYSv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVEYSv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVEYSuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:50:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53635 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262381AbVEYSuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:50:10 -0400
Subject: Re: RT patch acceptance
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Sven Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050525060551.GA5164@elte.hu>
References: <1116978244.19926.41.camel@dhcp153.mvista.com>
	 <20050525001019.GA18048@nietzsche.lynx.com>
	 <1116981913.19926.58.camel@dhcp153.mvista.com>
	 <20050525005942.GA24893@nietzsche.lynx.com>
	 <1116982977.19926.63.camel@dhcp153.mvista.com>
	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	 <20050524192029.2ef75b89.akpm@osdl.org>
	 <1116987976.2912.110.camel@mindpipe> <4293EFE8.1080106@yahoo.com.au>
	 <20050525060551.GA5164@elte.hu>
Content-Type: text/plain
Date: Wed, 25 May 2005 14:50:05 -0400
Message-Id: <1117047005.4473.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 08:05 +0200, Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > Lee Revell wrote:
> > 
> > > The IDE IRQ handler can in fact run for several ms, which people 
> > > sure can detect.
> > 
> > Are you serious? Even at 10ms, the monitor refresh rate would have to 
> > be over 100Hz for anyone to "notice" anything, right?... [...]
> 
> you are assuming direct observation. Sure, a human (normally) doesnt 
> notice smaller than say 10-20 msec of lag. But, a human very much 
> notices indirect effects of latencies, such as the nasty 'click' a 
> soundcard produces if it overruns.
> 
> > What sort of numbers are you talking when you say several?
> 
> a couple of msecs easily even on fast boxes. Well over 10 msecs on 
> slower boxes.
> 

Right, normal desktop use on a fast machine probably won't notice.  But
if you're trying to play a softsynth with a MIDI keyboard, 10ms is about
the threshold of perceptible lag.  I think it's reasonable to expect
this to work without having to customize your kernel for low latency.

If you're trying to plug your guitar into the line in, and put some
LADSPA effects on it, then the threshold is really 3-5ms, because
keyboard players are used to more latency (think about the mechanics of
striking a piano key vs. plucking a string with a pick).

I don't think sub-millisecond latencies are needed with the default
config.  But, both of the above should work OOTB like on Windows and
OSX.

Lee 




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282867AbRLGR4Z>; Fri, 7 Dec 2001 12:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282877AbRLGR4Q>; Fri, 7 Dec 2001 12:56:16 -0500
Received: from avplin.lanet.lv ([195.13.129.97]:59881 "HELO avplin.lanet.lv")
	by vger.kernel.org with SMTP id <S282878AbRLGR4D>;
	Fri, 7 Dec 2001 12:56:03 -0500
Date: Fri, 7 Dec 2001 19:37:45 +0200 (WET)
From: Andris Pavenis <pavenis@lanet.lv>
To: Nathan Bryant <nbryant@optonline.net>
Cc: linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH] i810_audio fix for version 0.11
In-Reply-To: <3C10F9E0.7010906@optonline.net>
Message-ID: <Pine.A41.4.05.10112071930350.74408-100000@ieva06>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Dec 2001, Nathan Bryant wrote:

> Andris Pavenis wrote:
> 
> >  > With this patch, it seems to work fine. Without, it hangs on write.
> > 
> > I met case when dmabuf->count==0 when __start_dac() is called. As result
> > I still got system freezing even if PCM_ENABLE_INPUT or 
> > PCM_ENABLE_OUTPUT were set accordingly (I used different patch, see 
> > another patch I sent today).
> > 
> > My latest revision of patch "survives" without problems already some 
> > hours (normally I'm not listening radio through internet all time, but 
> > this time I do ...)
> > 
> > Andris
> 
> i knew i shoula been a little less lazy with that one...
> 
> haven't looked at your revision yet but we should just clean up and make 
> update_lvi self-contained so that it always does *something* appropriate 
> regardless of state. maybe that's what you did. ;-)
> 
> (fyi, i'm not subscribed to linux-kernel, too much volume for the few 
> specific interests i have, i don't see some of this stuff until, and if, 
> i go digging thru archives)
> 

It seems that I can remove debug code from my version of update (or put
it inside '#ifdef DEBUG'). I'm torturing it practically without stop
and no problems found yet (initially listening some radio station with
RealPlayer, now put noatun playing one MP3 in a loop without stop)

About my patch: I changed __start_dac, start_dac, __start_adc and
start_adc to return integer (non zero if it is doing something at all).
I used this return code to see whether I should do a loop in 
__i810_update_lvi. 

At least I haven't got any message from debuging output I left in.

Andris





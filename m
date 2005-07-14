Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbVGNUmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVGNUmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbVGNUmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:42:23 -0400
Received: from graphe.net ([209.204.138.32]:57217 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262929AbVGNUmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:42:16 -0400
Date: Thu, 14 Jul 2005 13:41:44 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Linus Torvalds <torvalds@osdl.org>
cc: john stultz <johnstul@us.ibm.com>, Arjan van de Ven <arjan@infradead.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       lkml <linux-kernel@vger.kernel.org>, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <Pine.LNX.4.58.0507141307060.19183@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0507141340001.17567@graphe.net>
References: <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe>
 <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>
  <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> 
 <20050714005106.GA16085@taniwha.stupidest.org> 
 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> 
 <1121304825.4435.126.camel@mindpipe>  <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
  <1121326938.3967.12.camel@laptopd505.fenrus.org>  <20050714121340.GA1072@ucw.cz>
  <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org>  <1121360561.3967.55.camel@laptopd505.fenrus.org>
 <1121370122.7673.161.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0507141307060.19183@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2005, Linus Torvalds wrote:

> So the _sane_ way to do timeouts is to define an _arbitrary_ clock that is 
> just an integer counter. None of this "nanoseconds + full seconds" crap. 
> None of this stupid confusion with "real time". You select something that 
> is conceptually _clearly_ somethign else, and that will never get confused 
> when root sets the time backwards or anything like that.
> 
> In other words, you select the thing we call "jiffies".

AFAIK John simply wants to change jiffies to count in nanoseconds since 
bootup and then call it "clock_monotonic". One 64 bit value no splitting 
into seconds and nanoseconds anymore. This allows arbitrary length 
intervals between timer interrupts.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275256AbTHGJ4B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275267AbTHGJ4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:56:00 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:57017
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275256AbTHGJz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:55:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.0-test2-mm3 osdl-aim-7 regression
Date: Thu, 7 Aug 2003 20:01:13 +1000
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200308061910.h76JAYw16323@mail.osdl.org> <200308071541.06091.kernel@kolivas.org> <3F320D15.7020403@cyberone.com.au>
In-Reply-To: <3F320D15.7020403@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308072001.13740.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003 18:25, Nick Piggin wrote:
> >The more frequently you round robin the lower the scheduler latency
> > between SCHED_OTHER tasks of the same priority. However, the longer the
> > timeslice the more benefit you get from cpu cache. Where is the sweet
> > spot? Depends on the hardware and your usage requirements of course, but
> > Ingo has empirically chosen 25ms after 50ms seemed too long. Basically
> > cache trashing becomes a real problem with timeslices below ~7ms on
> > modern hardware in my limited testing. A minor quirk in Ingo's original
> > code means _occasionally_ a task will be requeued with <3ms to go. It
> > will be interesting to see if fixing this (which O12.2+ does) makes a big
> > difference or whether we need to reconsider how frequently (if at all) we
> > round robin tasks.
>
> Why not have it dynamic? CPU hogs get longer timeslices (but of course
> can be preempted by higher priorities).

Funny you should say that. Before Ingo merged his A3 changes, that's what my 
version of them did.

Con


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271114AbUJVAha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271114AbUJVAha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271163AbUJVAdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:33:16 -0400
Received: from fmr05.intel.com ([134.134.136.6]:11670 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271143AbUJVAaB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:30:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: gradual timeofday overhaul
Date: Thu, 21 Oct 2004 17:29:15 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F96E2@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gradual timeofday overhaul
Thread-Index: AcS3zRkAByNilTZoT6WGTFIipWIjdQAAIF8g
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <george@mvista.com>
Cc: <root@chaos.analogic.com>, "Brown, Len" <len.brown@intel.com>,
       "Tim Schmielau" <tim@physik3.uni-rostock.de>,
       "john stultz" <johnstul@us.ibm.com>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Oct 2004 00:29:37.0483 (UTC) FILETIME=[3644A1B0:01C4B7CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: George Anzinger [mailto:george@mvista.com]
>
> > This is just talking out of my ass, but I guess that for each invocation
> > they will have more or less the same overhead in execution time, let's
> > say T. For the periodic tick, the total overhead (in a second) is T*HZ;
> > with tickless, it'd be T*number_of_context_switches_per_second, right?
> 
> ???  Better look again.  Context switches can and do happen as often as 10 or so
> micro seconds (depends a lot on the cpu speed).  I admit this is with code that
> is just trying to measure the context switch time, but, often the system will
> change it mind just that fast.

As I said, I was talking out of my ass [aka, I didn't know and was just 
guesstimating for the heck of it], so I am happily proven wrong--thanks to
Chris and you--I guess I didn't take into account voluntary yielding of
the CPU by a task; I was more guiding myself for kicked out by a timer
making a task runnable, or a timeslice expiring, etc...which now are 
more or less guided by the tick [and then of course, we have IRQs,
but that's another matter]

> ...
> sourceforge).  On the other hand, where I come from, a system which has
> increasing overhead with load is one that is going to overload.  We are always
> better off if we can figure a way to have fixed overhead.
> 
> As for the idle system ticks, I think the VST stuff we are working on is the
> right answer.

Once my logic is proven wrong, then it makes full sense :]

Thanks for the heads up.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)

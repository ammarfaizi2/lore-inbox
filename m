Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVGHIsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVGHIsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 04:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVGHIsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 04:48:53 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:43789 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262364AbVGHIsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 04:48:21 -0400
Message-ID: <57445.195.245.190.94.1120812419.squirrel@www.rncbc.org>
In-Reply-To: <49943.192.168.1.5.1120778373.squirrel@www.rncbc.org>
References: <1119299227.20873.113.camel@cmn37.stanford.edu>   
    <20050621105954.GA18765@elte.hu>   
    <1119370868.26957.9.camel@cmn37.stanford.edu>   
    <20050621164622.GA30225@elte.hu>   
    <1119375988.28018.44.camel@cmn37.stanford.edu>   
    <1120256404.22902.46.camel@cmn37.stanford.edu>   
    <20050703133738.GB14260@elte.hu>   
    <1120428465.21398.2.camel@cmn37.stanford.edu>   
    <24833.195.245.190.94.1120761991.squirrel@www.rncbc.org>   
    <20050707194914.GA1161@elte.hu>
    <49943.192.168.1.5.1120778373.squirrel@www.rncbc.org>
Date: Fri, 8 Jul 2005 09:46:59 +0100 (WEST)
Subject: realtime-preempt-2.6.12-final-V0.7.51-11 glitches [no more]
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 08 Jul 2005 08:48:20.0702 (UTC) FILETIME=[CAE2BFE0:01C58399]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.

Just for the heads up, here goes todays summary results regarding
my jack_test4.2 test suite against 2.6.12 kernels configured with
PREEMPT_RT, but... now with 99.9% certainty :)

  ------------------------------ ------------- -------------
                                 RT-V0.7.51-13 RT-V0.7.49-01
  ------------------------------ ------------- -------------
  Total seconds ran . . . . . . :      900           900
  Number of clients . . . . . . :       14            14
  Ports per client  . . . . . . :        4             4
  Frames per buffer . . . . . . :       64            64
  Number of runs  . . . . . . . :        1             1
  ------------------------------ ------------- -------------
  Failure Rate  . . . . . . . . :   (    0.0 )    (    0.0)  /hour
  XRUN Rate . . . . . . . . . . :        0.0           0.0   /hour
  Delay Rate (>spare time)  . . :        0.0           0.0   /hour
  Delay Rate (>1000 usecs)  . . :        0.0           0.0   /hour
  Delay Maximum . . . . . . . . :      333           295     usecs
  Cycle Maximum . . . . . . . . :      970           943     usecs
  Average DSP Load. . . . . . . :       45.7          44.4   %
  Average CPU System Load . . . :       15.6          16.3   %
  Average CPU User Load . . . . :       32.0          30.1   %
  Average CPU Nice Load . . . . :        0.0           0.0   %
  Average CPU I/O Wait Load . . :        0.0           0.1   %
  Average CPU IRQ Load  . . . . :        0.0           0.0   %
  Average CPU Soft-IRQ Load . . :        0.0           0.0   %
  Average Interrupt Rate  . . . :     1678.6        1680.4   /sec
  Average Context-Switch Rate . :    14446.4       14463.2   /sec
  ------------------------------ ------------- -------------

Just for the forgiveness sake, my mistake was useful after all,
where one can incidentally assert the significantly lower performance
of PREEMPT_DESKTOP for audio work, when PREEMPT_RT is a clear winner.

As it was already, for quite some time. No more worries ;)

Thanks,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVATE4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVATE4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 23:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVATE4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 23:56:23 -0500
Received: from mail.joq.us ([67.65.12.105]:65186 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261741AbVATE4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 23:56:16 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
	<873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>
	<87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 19 Jan 2005 22:57:27 -0600
In-Reply-To: <41EF2E7E.8070604@kolivas.org> (Con Kolivas's message of "Thu,
 20 Jan 2005 15:07:26 +1100")
Message-ID: <87oefkd7ew.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Jack O'Quin wrote:
>> Outstanding.  How do you get rid of that checkerboard grey
>> background in the graphs?
>
>> Con Kolivas <kernel@kolivas.org> writes:
> Funny; that's the script you sent me so... beats me?

It's just one of the many things I don't understand about graphics.  

If I look at those png's locally (with gimp or gqview) they have a
dark grey checkerboard background.  If I look at them on the web (with
galeon), the background is white.  Go figure.  Maybe the file has no
background?  I dunno.

>> Looking at the graphs, your system has a substantial 4 to 6 msec delay
>> on approximately 40 second intervals, regardless of which scheduling
>> class or how many clients you run.  I'm guessing this is a recurring
>> long code path in the kernel and not a scheduling artifact at all.
>
> Probably. No matter what I do the hard drive seems to keep trying to
> spin down. Might be related.

I was misreading the x-axis.  They're actually every 20 sec.  My
system isn't doing that.

> in the background:
> while true ; do make clean && make ; done
>
> SCHED_ISO with 40 clients:
> *********************************************
> Timeout Count . . . . . . . . :(    0)
> XRUN Count  . . . . . . . . . :     3
> Delay Count (>spare time) . . :    20
> Delay Count (>1000 usecs) . . :     0
> Delay Maximum . . . . . . . . :  5841   usecs
> Cycle Maximum . . . . . . . . :   891   usecs
> Average DSP Load. . . . . . . :    34.1 %
> Average CPU System Load . . . :    10.7 %
> Average CPU User Load . . . . :    87.8 %
> Average CPU Nice Load . . . . :     0.0 %
> Average CPU I/O Wait Load . . :     0.7 %
> Average CPU IRQ Load  . . . . :     0.8 %
> Average CPU Soft-IRQ Load . . :     0.0 %
> Average Interrupt Rate  . . . :  1711.4 /sec
> Average Context-Switch Rate . : 20751.6 /sec
> *********************************************

The scheduler seems to be working great.  

You're really getting hammered with those periodic 6 msec delays,
though.  The basic audio cycle is only 1.45 msec.
-- 
  joq

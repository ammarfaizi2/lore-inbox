Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267475AbUHECxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbUHECxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUHECxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:53:45 -0400
Received: from mail019.syd.optusnet.com.au ([211.29.132.73]:17100 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267308AbUHECxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:53:41 -0400
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au> <20040804103143.GA13072@elte.hu> <cone.1091616443.996442.9775.502@pc.kolivas.org> <20040804124538.GA15505@elte.hu>
Message-ID: <cone.1091674380.801763.9775.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Date: Thu, 05 Aug 2004 12:53:00 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:

> 
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
>> Ingo Molnar writes:
>> 
>> Thanks for replying.
>> 
>> >* Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>> >
>> >>Also, basic interactivity in X is bad with the interactive sysctl set
>> >>to 0 (is X supposed to be at nice 0?), however fairness is bad when
>> >>interactive is 1. I'm not sure if this is an acceptable tradeoff - are
>> >>you planning to fix it?
>> >
>> >it also has clear interactivity problems when just running lots of CPU
>> >hogs even with the default interactive=1 compute=0 setting.
>> 
>> Can you define them please? I haven't had any reported to me.
> 
> sure: take a process that uses 85% of CPU time (and sleeps 15% of the
> time) if running on an idle system. Start just two of these hogs at
> normal priority. 2.6.8-rc2-mm2 becomes almost instantly unusable even
> over a text console: a single 'top' refresh takes ages, 'ls' displays
> one line per second or so. Start more of these and the system
> effectively locks up.

It's only if I physically try and create such a test application that I can 
reproduce it. I haven't found any real world load that does that - but of 
course that doesn't mean I should discount it. However, interactive mode off 
doesn't exhibit it and it should be easy enough to fix for interactive mode 
on. Thanks for pointing it out.

Cheers,
Con


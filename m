Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUHDLM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUHDLM1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 07:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUHDLM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 07:12:27 -0400
Received: from mail021.syd.optusnet.com.au ([211.29.132.132]:65168 "EHLO
	mail021.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264911AbUHDLMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 07:12:24 -0400
References: <cone.1091580026.552226.9775.502@pc.kolivas.org> <s5h3c33qi67.wl@alsa2.suse.de>
Message-ID: <cone.1091617935.816034.9775.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduler policies for staircase
Date: Wed, 04 Aug 2004 21:12:15 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai writes:

> At Wed, 04 Aug 2004 10:40:26 +1000,
> Con Kolivas wrote:
>> schediso - this implements soft real time scheduling for non-privileged 
>> tasks (isochronous scheduling).
> 
> I'd love to see SCHED_ISO is introduced.
> It helps the normal audio streaming.
> 
> (but not sure about the video streaming - what happens when the stream
> handling is CPU bound?)

I use "streamer" in sched iso mode, and do the video encoding in a separate 
application (mencoder) through a pipe. So it's a simple threading issue 
where the capture thread is run in sched iso, and the cpu bound encoding 
sched normal.

Cheers,
Con


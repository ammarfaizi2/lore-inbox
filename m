Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVATPSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVATPSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 10:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVATPSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 10:18:49 -0500
Received: from mail.joq.us ([67.65.12.105]:5560 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S262124AbVATPSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 10:18:46 -0500
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
	<87oefkd7ew.fsf@sulphur.joq.us> <41EF48BA.50709@kolivas.org>
	<41EF5122.2000605@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Thu, 20 Jan 2005 09:19:37 -0600
In-Reply-To: <41EF5122.2000605@kolivas.org> (Con Kolivas's message of "Thu,
 20 Jan 2005 17:35:14 +1100")
Message-ID: <87pt00b01i.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

>> Jack O'Quin wrote:
>>> You're really getting hammered with those periodic 6 msec delays,
>>> though.  The basic audio cycle is only 1.45 msec.

> Con Kolivas wrote:
>> As you've already pointed out, though, they occur even with
>> SCHED_FIFO so I'm certain it's an artefact unrelated to cpu
>> scheduling.

Yes.  Your scheduler works well.

> Ok to try and answer my own possibility I) remounted reiserfs with the
> nolog option and tested with SCHED_ISO

That's discouraging about reiserfs.  Is it version 3 or 4?  Earlier
versions showed good realtime responsiveness for audio testers.  It
had a reputation for working much better at lower latency than ext3.

How do we report this problem to the developers?

> That the 20s periodic thing delay has all but gone. Just one towards
> the end (no idea what that was).

I need to figure out how to use Takashi's ALSA xrun debugger.  It
prints the kernel stack when an xrun occurs.

-- 
  joq

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVAXGfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVAXGfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVAXGdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:33:08 -0500
Received: from mail.joq.us ([67.65.12.105]:37592 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261471AbVAXG3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:29:06 -0500
To: Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 24 Jan 2005 00:30:48 -0600
In-Reply-To: <20050120172506.GA20295@elte.hu> (Ingo Molnar's message of
 "Thu, 20 Jan 2005 18:25:06 +0100")
Message-ID: <877jm3qqxz.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> just finished a short testrun with nice--20 compared to SCHED_FIFO, on a
> relatively slow 466 MHz box:

Has anyone done this kind of realtime testing on an SMP system?  I'd
love to know how they compare.  Unfortunately, I don't have access to
one at the moment.  Are they generally better or worse for this kind
of work?  I'm not asking about partitioning or processor affinity, but
actually using the entire SMP complex as a realtime machine.

Our current jack_test scripts wouldn't exercise a multiprocessor very
well.  But, even those results would be interesting to know.  Then, I
think we could modify them to start muliple JACK servers.  That will
probably require using the dummy backend driver, which would need a
more accurate timer source than its current usleep() call to provide
reliable low latency results.  (We currently drive the audio cycle
from ALSA driver interrupts, but each JACK server requires a dedicated
sound card for that.)
-- 
  joq

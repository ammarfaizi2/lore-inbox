Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030808AbWJDKpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030808AbWJDKpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030809AbWJDKpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:45:40 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:64421 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030808AbWJDKpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:45:39 -0400
From: Dominique Dumont <domi.dumont@free.fr>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       alsa-user <alsa-user@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-user] Pb with simultaneous SATA and ALSA I/O
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	<20060925143838.GQ13641@csclub.uwaterloo.ca>
	<1159195859.2899.72.camel@mindpipe>
Date: Wed, 04 Oct 2006 12:45:35 +0200
In-Reply-To: <1159195859.2899.72.camel@mindpipe> (Lee Revell's message of
	"Mon, 25 Sep 2006 10:50:59 -0400")
Message-ID: <87hcyk4awg.fsf@gandalf.hd.free.fr>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: domi.dumont@free.fr
X-SA-Exim-Scanned: No (on gandalf.hd.free.fr); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> It might not be interrupt related, it could be DMA starvation.  This has
> been observed with some SATA controllers while testing the -rt patches.
> The symptom is that the latency traces show the machine going in "slow
> motion".
>
> Dominique: try the -rt kernel, enable latency tracing and post the
> output.

Done. I've tried with 2.6.18-rt5. CONFIG_LATENCY_TRACE is enabled.

Here are the results (still with running "ac3dec -C " and "md5sum *"
on a SATA drive): 
- I get no more ALSA xrun.
- /proc/latency_trace is empty
- dolby digital output is still considerably chopped.

Note that the dolby digital output works fine when:
- No I/O is done 
- heavy I/O on pata HDD (md5sum *)
- heavy I/O on DVD reader (md5sum *)

Did I miss something with the latency_trace ?

Cheers

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVAZLCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVAZLCf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 06:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVAZLCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 06:02:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:32651 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262274AbVAZLCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 06:02:24 -0500
Date: Wed, 26 Jan 2005 12:02:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D7
Message-ID: <20050126110202.GA17983@elte.hu>
References: <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <87k6q2umla.fsf@sulphur.joq.us> <20050125083724.GA4812@elte.hu> <87oefdfaxp.fsf@sulphur.joq.us> <20050125214900.GA9421@elte.hu> <87sm4osrix.fsf@sulphur.joq.us> <20050126072712.GA1821@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126072712.GA1821@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've uploaded a simple utility to set the RT_CPU rlimit, called
execrtlim:

  http://redhat.com/~mingo/rt-limit-patches/

execrtlim can be used to test the rlimit, e.g.:

  ./execrtlim 10 10 /bin/bash

will spawn a new shell with RLIMIT_RT_CPU curr/max set to 10%/10%.

on older kernels the utility prints:

  $ ./execrtlim 10 10 /bin/bash
  execrtlim: kernel does not support RLIMIT_RT_CPU.

	Ingo

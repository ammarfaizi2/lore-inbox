Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWCHOHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWCHOHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 09:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWCHOHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 09:07:41 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:22169 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751034AbWCHOHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 09:07:40 -0500
Date: Wed, 8 Mar 2006 15:06:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: karsten wiese <annabellesgarden@yahoo.de>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       cc@ccrma.Stanford.EDU
Subject: Re: [Alsa-devel] Re: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
Message-ID: <20060308140635.GA16972@elte.hu>
References: <1141800836.6150.3.camel@cmn3.stanford.edu> <20060308133635.96547.qmail@web26507.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308133635.96547.qmail@web26507.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* karsten wiese <annabellesgarden@yahoo.de> wrote:

> ALSA Midi sequencer uses tasklets. there are 2 kinds of
> them: lo and hi.
> In rt-18 PREEMPT-RT, tasklet_hi_schedule() didn't work,
> 'cause it woke up tasklet_lo's thread.
> Thats what my patch fixed.

ah - i thought that -rt18 had your fix already - but indeed it's -rt19 
that added it. So it's probably the same bug.

	Ingo

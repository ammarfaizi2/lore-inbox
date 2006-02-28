Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWB1Tob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWB1Tob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWB1Tob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:44:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33175 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932518AbWB1Toa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:44:30 -0500
Date: Tue, 28 Feb 2006 20:43:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt17
Message-ID: <20060228194313.GA23453@elte.hu>
References: <200602282021.21052.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602282021.21052.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <annabellesgarden@yahoo.de> wrote:

> > the tasklet code was reworked too to be PREEMPT_RT friendly: the new PI 
> > code unearthed a fundamental livelock scenario with PREEMPT_RT, and the 
> > fix was to rework the tasklet code to get rid of the 'retrigger 
> > softirqs' approach.
> 
> following patch re enables tasklet_hi.
> needed by ALSA MIDI.

ahh ... this indeed explains some of the bugreports! Applied.

	Ingo

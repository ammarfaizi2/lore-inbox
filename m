Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVDJR2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVDJR2l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVDJR2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:28:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64920 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261523AbVDJR22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:28:28 -0400
Date: Sun, 10 Apr 2005 19:27:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
Message-ID: <20050410172759.GA16654@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu> <42596101.3010205@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42596101.3010205@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo,
> 
> It would seem that in the latest patch RT-V0.7.45-00 we have reverted 
> back to removing the define of jbd_debug which the attached patch 
> (against one of the 2.6.11 versions) fixed.

> +#define jbd_debug(f, a...)   /**/

oops, indeed. '/**/' happens to be my private marker for 'debug code', 
which the release scripts automatically strip from the files ...

i've uploaded -45-01 with the fix.

	Ingo

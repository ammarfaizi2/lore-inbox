Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUISVLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUISVLI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 17:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUISVLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 17:11:08 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:9338 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264085AbUISVLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 17:11:03 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Date: Sun, 19 Sep 2004 23:11:37 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200409192232.20139.annabellesgarden@yahoo.de> <20040919204841.GA7004@elte.hu>
In-Reply-To: <20040919204841.GA7004@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409192311.37639.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag 19 September 2004 22:48 schrieb Ingo Molnar:
>
> The point is to let gettimeofday(0,1) start tracing and
> gettimeofday(0,0) stop tracing - a system-call-controlled tracing
> facility (if trace_enabled=2). This was used to trace weird latencies
> before, but it's not the normal mode of operation.
>
Ok. The other point is a page_fault being generated later on in 
sys_gettimeofday() if tz is not reset:
>>>>
	if (unlikely(tz != NULL)) {
                     ^^
		if (copy_to_user(tz, &sys_tz, sizeof(sys_tz)))
			return -EFAULT;
	}
<<<<

What do you think about including the swapspace-layout-improvements in the 
voluntary-preempt patches?

best regards,
Karsten

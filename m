Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280817AbRK0Qsl>; Tue, 27 Nov 2001 11:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRK0Qsb>; Tue, 27 Nov 2001 11:48:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:52968 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S280817AbRK0Qs0>;
	Tue, 27 Nov 2001 11:48:26 -0500
Date: Tue, 27 Nov 2001 19:46:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc-based cpu affinity user interface
In-Reply-To: <Pine.LNX.4.40.0111270847300.1576-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0111271939440.23151-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Nov 2001, Davide Libenzi wrote:

> The snippet I sent yesterday should be corrected by checking if
> cpu_{number,logical}_map(ii) is != -1 to avoid incorrect bit settings,
> expecially from mask coming from user side.

indeed. New patch is at:

  http://redhat.com/~mingo/set-affinity-patches/set-affinity-2.4.16-A1

(the buggy function was not a security problem, it just produces
unexpected bitmaps.)

	Ingo


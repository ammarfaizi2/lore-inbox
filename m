Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131692AbQLVK3a>; Fri, 22 Dec 2000 05:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131814AbQLVK3U>; Fri, 22 Dec 2000 05:29:20 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131692AbQLVK3P>;
	Fri, 22 Dec 2000 05:29:15 -0500
Message-ID: <20001221210527.B1545@bug.ucw.cz>
Date: Thu, 21 Dec 2000 21:05:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: Steve Grubb <ddata@gate.net>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] performance enhancement for simple_strtoul
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <000e01c06a8e$6945db60$bc1a24cf@master>; from Steve Grubb on Wed, Dec 20, 2000 at 09:09:03AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The following patch is a faster implementation of the simple_strtoul
> function. This function differs from the original in that it reduces the
> multiplies to shifts and logical operations wherever possible. My testing
> shows that it adds around 100 bytes, but is about 6% faster on a K6-2. (It
> is 40% faster that glibc's strtoul, but that's a different story.) My guess
> is that the performance gain will be higher on platforms with slower
> multiplication instructions. I have tested it for numerical accuracy so I
> think this is safe to apply. If anyone is interested, I can also supply a
> test application that demonstrates the performance gain. This patch was
> generated against 2.2.16, but should apply to 2.2.19 cleanly. In
> 2.4.0-test9, simple_strtoul starts on line 19 rather than 17, hopefully
> that's not a problem.

Simple question: who cares about performance of simple_strtoul?

Original is shorter, and simple_strtoul is not performace
critical. Keep it as it is.

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

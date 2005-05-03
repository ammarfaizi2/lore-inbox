Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVECSbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVECSbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVECSbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:31:14 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:12181 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261539AbVECSaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:30:05 -0400
Subject: Re: question about contest benchmark
From: Lee Revell <rlrevell@joe-job.com>
To: Haoqiang Zheng <haoqiang@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d6e6e6dd05050311115d256213@mail.gmail.com>
References: <d6e6e6dd05050311115d256213@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 May 2005 14:29:59 -0400
Message-Id: <1115144999.29445.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-03 at 14:11 -0400, Haoqiang Zheng wrote:
>  My question is why is the result bad at all? One could certainly
> argue that contest processes shouldn't consume so much CPU time since
> they are considered to be background jobs. But why is kernel compiling
> considered foreground jobs? Why making kernel compiling faster is
> better?

I have reported the same problem before.  CPU bound processes like
kernel compiles will sometimes starve interactive processes like my mail
client (Evolution).

Actually, I discovered a horrible performance bug in Evolution
(suboptimal "hide junk" implementation, and searches for "" not properly
optimized away, see evolution-hackers for a rough patch) that was
responsible for the massive CPU suckage.

But, it seems to me that even if an interactive process briefly goes CPU
bound (due to bloat, bugs, or intent), it should still be scheduled
preferentially to a pure CPU bound process like a build.

Lee


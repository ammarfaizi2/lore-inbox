Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVGLPBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVGLPBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVGLO7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:59:01 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:400 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261493AbVGLO50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:57:26 -0400
Subject: Re: ondemand cpufreq ineffective in 2.6.12 ?
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Eric Piel <Eric.Piel@lifl.fr>, Ken Moffat <ken@kenmoffat.uklinux.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200507122152.26106.kernel@kolivas.org>
References: <Pine.LNX.4.58.0507111702410.2222@ppg_penguin.kenmoffat.uklinux.net>
	 <Pine.LNX.4.58.0507121203450.7944@ppg_penguin.kenmoffat.uklinux.net>
	 <42D3AE47.7070208@lifl.fr>  <200507122152.26106.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 10:57:23 -0400
Message-Id: <1121180244.2632.55.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 21:52 +1000, Con Kolivas wrote:
> > Well, it's just the default settings of the kernel which has changed. If
> > you want the old behaviour, you can use (with your admin hat):
> > echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/ignore_nice
> > IMHO it seems quite fair, if you have a process nice'd to 10 it probably
> > means you are not in a hurry.
> 
> That's not necessarily true. Most people use 'nice' to have the cpu bound task 
> not affect their foreground applications, _not_ because they don't care how 
> long they take.

But the scheduler should do this on its own!  If people are having to
renice kernel compiles to maintain decent interactive performance (and
yes, I have to do the same thing sometimes) the scheduler is BROKEN,
period.

Lee


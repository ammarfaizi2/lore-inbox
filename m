Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVBQUFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVBQUFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVBQUFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:05:55 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:4817 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262337AbVBQUFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:05:31 -0500
Subject: Re: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Philippe Elie <phil.el@wanadoo.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050213133020.GA16363@elte.hu>
References: <1108274835.3739.2.camel@krustophenia.net>
	 <20050213130058.GA566@zaniah>  <20050213133020.GA16363@elte.hu>
Content-Type: text/plain
Date: Thu, 17 Feb 2005 15:05:26 -0500
Message-Id: <1108670727.11411.6.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-13 at 14:30 +0100, Ingo Molnar wrote:
> * Philippe Elie <phil.el@wanadoo.fr> wrote:
> 
> > oprofile_ops.cpu_type == NULL, this has been fixed 3 weeks ago, can
> > you retry with -rc4 ?
> 
> i've uploaded an -rc4 port of the -RT tree half an hour ago (-39-00).
> 

Thanks, -rc4 did fix the bug.

I noticed profiling the kernel with PREEMPT_DESKTOP that mcount and
__mcount add quite a bit of overhead.  Something like .5% CPU each.
Sorry, I didn't save the oprofile output.

So, disable CONFIG_MCOUNT if you want minimal overhead from the RT
patches.  IIRC it was previously stated that the latency tracing
overhead could be mostly avoided by disabling it at runtime.

Lee 


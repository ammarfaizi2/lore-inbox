Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUA1Tki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUA1Tkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:40:31 -0500
Received: from ns.suse.de ([195.135.220.2]:4323 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266144AbUA1TjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:39:17 -0500
Date: Wed, 28 Jan 2004 20:39:15 +0100
From: Andi Kleen <ak@suse.de>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, iod00d@hp.com, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
Message-Id: <20040128203915.22d84e8d.ak@suse.de>
In-Reply-To: <16408.3157.336306.812481@napali.hpl.hp.com>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
	<20040128172004.GB5494@cup.hp.com>
	<20040128184137.616b6425.ak@suse.de>
	<16408.30.896895.980121@napali.hpl.hp.com>
	<20040128195246.47a84498.ak@suse.de>
	<16408.3157.336306.812481@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 11:24:05 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> >>>>> On Wed, 28 Jan 2004 19:52:46 +0100, Andi Kleen <ak@suse.de> said:
> 
>   >> I find this comment interesting.  Can you elaborate what you mean by
>   >> "slightly buggy systems"?
> 
>   Andi> e.g. one bit ECC errors in memory are quite common.  And with
>   Andi> ECC memory they are not really fatal.
> 
> Yet they are a good indicator that something is wrong (not performing
> properly) or may be failing soon.  I don't think putting on blinders
> for such problems is a good idea.  Though I agree that the question of

Most server class hardware should log it somewhere and allow 
to read the event log in the firmware. This even works for unhandleable
errors unlike what the OS could do.

But when printed in Linux they will report it to the linux maintainer or their 
distribution vendor.  "My Linux is buggy and giving these weird messages" And they
are both in no position at all to do something about it. 

I toyed with the idea of printking a disclaimer of
"This is likely not a software bug. Report it to your hardware vendor."
But I doubt this would help much. Even when you say clearly in the message
that the hardware failed the user sees a weird message and thinks 
it is Linux's fault.

You could enable it with CONFIG_I_HAVE_A_HARDWARE_SUPPORT_CONTRACT_OR_I_WRITE_DRIVERS
Or just make it a kernel command line option with off by default.

-Andi

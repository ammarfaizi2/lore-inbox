Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUA1UBi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUA1UBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:01:38 -0500
Received: from ns.suse.de ([195.135.220.2]:48769 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266202AbUA1UBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:01:35 -0500
Date: Wed, 28 Jan 2004 21:01:32 +0100
From: Andi Kleen <ak@suse.de>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, iod00d@hp.com, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
Message-Id: <20040128210132.2b0e5a96.ak@suse.de>
In-Reply-To: <16408.4597.123125.788631@napali.hpl.hp.com>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
	<20040128172004.GB5494@cup.hp.com>
	<20040128184137.616b6425.ak@suse.de>
	<16408.30.896895.980121@napali.hpl.hp.com>
	<20040128195246.47a84498.ak@suse.de>
	<16408.3157.336306.812481@napali.hpl.hp.com>
	<20040128203915.22d84e8d.ak@suse.de>
	<16408.4597.123125.788631@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 11:48:05 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> >>>>> On Wed, 28 Jan 2004 20:39:15 +0100, Andi Kleen <ak@suse.de> said:
> 
>   >> Yet they are a good indicator that something is wrong (not performing
>   >> properly) or may be failing soon.  I don't think putting on blinders
>   >> for such problems is a good idea.  Though I agree that the question of
> 
>   Andi> Most server class hardware should log it somewhere and allow
>   Andi> to read the event log in the firmware. This even works for
>   Andi> unhandleable errors unlike what the OS could do.
> 
> And you'd want to reboot your server just so you can check on the soft
> failure rate? ;-)

Yep, I reboot my machines all the time ;-) 

Seriously you can count it somewhere and present it in sysfs or /proc.
Or log it somewhere else and supply a special utility to show them
that makes it clear that the events are hardware and not software related.
I suppose if your server vendor is serious they will supply a tool
to read the firmware log from a running system.

But printks enabled by default are a bad idea (and a bug too BTW - printk called from 
MCE handlers can randomly deadlock) 

-Andi

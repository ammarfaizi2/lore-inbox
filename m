Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266109AbUA1Sy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266140AbUA1Sy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:54:58 -0500
Received: from ns.suse.de ([195.135.220.2]:54720 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266109AbUA1Sy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:54:56 -0500
Date: Wed, 28 Jan 2004 19:52:46 +0100
From: Andi Kleen <ak@suse.de>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, iod00d@hp.com, ishii.hironobu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
Message-Id: <20040128195246.47a84498.ak@suse.de>
In-Reply-To: <16408.30.896895.980121@napali.hpl.hp.com>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com>
	<20040128172004.GB5494@cup.hp.com>
	<20040128184137.616b6425.ak@suse.de>
	<16408.30.896895.980121@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 10:31:58 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> >>>>> On Wed, 28 Jan 2004 18:41:37 +0100, Andi Kleen <ak@suse.de> said:
> 
>   Andi> Also in my experience from AMD64 which originally was a bit
>   Andi> aggressive on enabling MCEs: enabling MCEs increases your
>   Andi> kernel support load a lot.
> 
>   Andi> Many people have slightly buggy systems which still happen to
>   Andi> work mostly.  If you report every problem you as kernel
>   Andi> maintainer will be flooded with reports about things you can
>   Andi> nothing to do about.
> 
> I find this comment interesting.  Can you elaborate what you mean by
> "slightly buggy systems"?

e.g. one bit ECC errors in memory are quite common.  And with ECC memory 
they are not really fatal. Similar with drivers. A lot of drivers do 
bus aborts and other things regularly, but there is not necessarily 
data corruption.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968453AbWLEQuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968453AbWLEQuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968448AbWLEQuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:50:40 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:7166 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968453AbWLEQuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:50:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g9PFOTmHc8QMCg1oUwHLtcT3DgBGRjb/896GGjRqTdhW5a/SZQzZe+OsDgR1Dcq38vmMpVTKVKxrp1Ym3PwL1tJD0PnMNpBpv7wih+MnQDmKwMLX/tfOLRHwfv2IrsdcCmgyw9sh0S/JXk7Vdds/5tMY/l7N+WQHiEqKJSPlBis=
Message-ID: <aa5953d60612050850v240b382fm172702b1d28934a1@mail.gmail.com>
Date: Tue, 5 Dec 2006 22:20:35 +0530
From: "Jaswinder Singh" <jaswinderrajput@gmail.com>
To: "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>
Subject: Re: PREEMPT is messing with everyone
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45758B57.6040107@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <aa5953d60612050610l1f2657c3ie073467a2b2a7126@mail.gmail.com>
	 <45758B57.6040107@stud.feec.vutbr.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/06, Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
> Jaswinder Singh wrote:
> > Hi,
> >
> > preempt stuff SHOULD only stay in #ifdef CONFIG_PREEMP_* , but it is
> > messing with everyone even though not defined.
> >
> > e.g.
> >
> > 1. linux-2.6.19/kernel/spinlock.c
> >
> > Line 18: #include <linux/preempt.h>
> >
> > Line 26:  preempt_disable();
> >
> > Line 32:  preempt_disable();
> >
> > and so on .
>
> Don't worry. These compile into "do { } while (0)" (i.e. nothing) when
> CONFIG_PREEMPT is not set.
>

Yes, Compiler will remove it but this looks ugly and confusing.

Why dont we use like this :-

#ifdef CONFIG_PREEMPT
#include <linux/preempt.h>
#endif

#ifdef CONFIG_PREEMPT
 preempt_disable();
#endif

#ifdef CONFIG_PREEMPT
 preempt_enable();
#endif

Regards,

Jaswinder Singh.

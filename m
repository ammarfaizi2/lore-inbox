Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbTDJWlN (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264216AbTDJWlN (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:41:13 -0400
Received: from [12.47.58.73] ([12.47.58.73]:35402 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264215AbTDJWlN (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:41:13 -0400
Date: Thu, 10 Apr 2003 15:53:03 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: proc_misc.c bug
Message-Id: <20030410155303.007d5bfe.akpm@digeo.com>
In-Reply-To: <1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
References: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
	<1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Apr 2003 22:52:50.0417 (UTC) FILETIME=[E9A8AE10:01C2FFB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Thu, 2003-04-10 at 23:02, David Mosberger wrote:
> > The workaround below is to allocate 4KB per 8 CPUs.  Not really a
> > solution, but the fundamental problem is that /proc/interrupts
> > shouldn't use a fixed buffer size in the first place.  I suppose
> > another solution would be to use vmalloc() instead.  It all feels like
> > bandaids though.
> 
> How about switching to Al's seqfile interface ?

It's already using it!  Not sure why it needs to buffer all the text in one
big slurp.

There are about 20 different show_interrupts()es which need updating if
someone decides to fix it for real.


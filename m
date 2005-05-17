Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVEQByI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVEQByI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 21:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVEQByH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 21:54:07 -0400
Received: from serv01.siteground.net ([70.85.91.68]:1721 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261221AbVEQByF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 21:54:05 -0400
Date: Mon, 16 May 2005 17:55:54 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel@vger.kernel.org, shai@scalex86.org, akpm@osdl.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
In-Reply-To: <1116276689.28764.1.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0505161755110.9418@ScMPusgw>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw> <1116276689.28764.1.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Lee Revell wrote:

> On Mon, 2005-05-16 at 12:45 -0700, christoph wrote:
> > Make the timer frequency selectable. The timer interrupt may cause bus
> > and memory contention in large NUMA systems since the interrupt occurs
> > on each processor HZ times per second.
> 
> Isn't there already a patch in the -ac kernel that allows HZ to be
> selected at runtime?

Runtime? That seems to be a bad idea. It would be better to rewrite the 
timer subsystem to be able to work tickless.


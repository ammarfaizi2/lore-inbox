Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWHKA6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWHKA6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHKA6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:58:17 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:7336 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S932409AbWHKA6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:58:16 -0400
Date: Thu, 10 Aug 2006 18:00:00 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic:BUG in cascade at kernel/timer.c
Message-ID: <20060811010000.GA3855@localhost.localdomain>
References: <F795765B112E7344AF36AA9112796415019ED349@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F795765B112E7344AF36AA9112796415019ED349@xmb-sjc-212.amer.cisco.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 02:26:15PM -0700, Bizhan Gholikhamseh (bgholikh) wrote:
> Hi All,
> We have developed our own custom board based on MPC8541 board running
> linux 2.6.11 During stress testing the system we get following kernel
> panic which related to timer cascase.
> Any hints greatly apprieciated. Many thanks in advance:

Is this an MP configuration?  If timer interrupts are distributed to more
than one cpu this could happen (buggy hardware). Also, I remember a missing 
barrier someplace for PPC which was fixed in newer kernels.  Read the GIT logs.

HTH
Kiran

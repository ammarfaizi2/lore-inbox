Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268767AbUJKRH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268767AbUJKRH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 13:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUJKREv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 13:04:51 -0400
Received: from main.gmane.org ([80.91.229.2]:48561 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268767AbUJKRDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 13:03:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrew Rodland <arodland@entermail.net>
Subject: Re: voluntary-preempt T3 latency spikes with fan speed change
Date: Mon, 11 Oct 2004 13:03:01 -0400
Message-ID: <ckeec5$id4$1@sea.gmane.org>
References: <20041009104702.GA14649@mobilat.informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: node135.wireless6.outside.ucf.edu
User-Agent: KNode/0.8.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torbenh@gmx.de wrote:

> 
> hi...
> 
> i am seeing latency spikes (ie jack xruns) when the fan of my
> asus l3d laptop changes speed.
> 
> is there any chance to fix this ?
> i have turned off acpi in the kernel, as this gives me latency spikes
> all over.
> 
> i am quite new to the VP patches, and want to help where i can.
> 
> i also got a quite strange latency trace here:
> 
> could someone sched some light on this please ?
> 

I can't say for certain, but I'm guessing that your laptop has a deeply
broken BIOS that implements ACPI and suchlike by using SMM, which blocks
out interrupts, and there's nothing, I believe, you can do about it.
Disabling ACPI seems sensible; at least you can avoid causing these delays
intentionally, but if some sensor interrupt triggers a flip into SMM to
enable the fan, you're just screwed for a number of milliseconds.

Andrew



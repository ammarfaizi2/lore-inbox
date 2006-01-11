Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWAKAKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWAKAKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWAKAKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:10:40 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:55509 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161024AbWAKAKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:10:39 -0500
Subject: Re: PCI DMA Interrupt latency
From: Lee Revell <rlrevell@joe-job.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43C44A54.5070702@shaw.ca>
References: <5trA6-6MD-39@gated-at.bofh.it>  <43C44A54.5070702@shaw.ca>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 19:10:36 -0500
Message-Id: <1136938237.2007.110.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 17:59 -0600, Robert Hancock wrote:
> Most likely some driver is disabling interrupts for that period, which 
> is really longer than it should be. However, if your card/driver require 
> such tight interrupt latency to function correctly, that seems too 
> fragile and may not be reliable. Some kind of ringbuffer arrangement 
> would likely work better, so that the interrupt does not have to be 
> serviced so soon.
> 

You can easily tell if this is the case by applying these patches:

http://people.redhat.com/mingo/latency-tracing-patches/latency-tracing-patches-2.6.15-rc7.tar.gz

It says -rc7 but they apply cleanly and work with 2.6.15 final.

Lee


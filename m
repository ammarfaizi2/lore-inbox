Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbUCRRty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbUCRRty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:49:54 -0500
Received: from peabody.ximian.com ([130.57.169.10]:4329 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262819AbUCRRs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:48:57 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Robert Love <rml@ximian.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040318145129.GA2246@dualathlon.random>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random>
	 <20040318015004.227fddfb.akpm@osdl.org>
	 <20040318145129.GA2246@dualathlon.random>
Content-Type: text/plain
Message-Id: <1079632130.6043.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 18 Mar 2004 12:48:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 09:51, Andrea Arcangeli wrote:

> the counter is definitely not optimized away, see:

This is because of work Dave Miller and Ingo did - irq count, softirq
count, and lock count (when PREEMPT=y) are unified into preempt_count. 

So it is intended.

The unification makes things cleaner and simpler, using one value in
place of three and one interface and concept in place of many others. 
It also gives us a single simple thing to check for an overall notion of
"atomicity", which is what makes debugging so nice.

	Robert Love



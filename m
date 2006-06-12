Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752148AbWFLSmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbWFLSmP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbWFLSmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:42:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:31644 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752148AbWFLSmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:42:14 -0400
Date: Mon, 12 Jun 2006 11:42:04 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: broken local_t on i386
In-Reply-To: <200606121935.02693.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606121139380.20123@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606121906.28692.ak@suse.de>
 <Pine.LNX.4.64.0606121124510.19770@schroedinger.engr.sgi.com>
 <200606121935.02693.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Andi Kleen wrote:

> Saving two instructions? And PDA is usually in L1. I doubt you could benchmark
> a difference.

The two instructions occur over and over again for each PDA reference. And 
then there are now two more instruction for disabling preempt and 
reenabling preempt.

A simple dec/inc <absolute location> would be nicely suitable for 
inlining per processor counters.



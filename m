Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWFLTAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWFLTAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWFLTAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:00:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:59291 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932065AbWFLTAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:00:08 -0400
Date: Mon, 12 Jun 2006 11:59:49 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: broken local_t on i386
In-Reply-To: <200606121955.47803.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606121156460.20195@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606121935.02693.ak@suse.de>
 <Pine.LNX.4.64.0606121139380.20123@schroedinger.engr.sgi.com>
 <200606121955.47803.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Andi Kleen wrote:

> Possible, but is it worth reinventing the linker?

How would that work?

IMHO The linker cannot help with virtual to physical address translations. 
A linker that will link per processor would be amazing. What happens if 
the process is rescheduled? We dynamically relink to the new processor?

I thought you had some funky segment registers on i386 and x86_64. Cant 
they be switched on context switch? If an inc/dec could work relative to 
those then you would not need a virtual mapping.




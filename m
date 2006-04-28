Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWD1QIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWD1QIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWD1QIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:08:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6297 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030444AbWD1QIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:08:16 -0400
Date: Fri, 28 Apr 2006 09:07:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "shin, jacob" <jacob.shin@amd.com>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ak@suse.de, "Langsdorf, Mark" <mark.langsdorf@amd.com>
Subject: Re: [PATCH] [1/1] slab: fix crash on __drain_alien_cahce() during
 CPU Hotplug
In-Reply-To: <B3870AD84389624BAF87A3C7B83149930293583F@SAUSEXMB2.amd.com>
Message-ID: <Pine.LNX.4.64.0604280904400.32541@schroedinger.engr.sgi.com>
References: <B3870AD84389624BAF87A3C7B83149930293583F@SAUSEXMB2.amd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006, shin, jacob wrote:

> transfer_objects should only be called when all of the cpus in the
> node are online.  CPU_DEAD notifier callback marks l3->shared to NULL.

Please drain the alien caches first then the shared caches and 
then finally mark l3->shared NULL.



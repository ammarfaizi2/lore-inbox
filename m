Return-Path: <linux-kernel-owner+w=401wt.eu-S1161085AbXALV2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbXALV2K (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbXALV2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:28:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56390 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161085AbXALV2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:28:08 -0500
Date: Fri, 12 Jan 2007 13:28:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, sander@humilis.net, linux-kernel@vger.kernel.org
Subject: Re: 'struct task_struct' has no member named 'mems_allowed'  (was:
 Re: 2.6.20-rc4-mm1)
In-Reply-To: <20070112132016.f11ffc8a.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0701121324060.2969@schroedinger.engr.sgi.com>
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070112105224.GA12813@favonius>
 <20070112032820.9c995718.pj@sgi.com> <Pine.LNX.4.64.0701121123410.2296@schroedinger.engr.sgi.com>
 <20070112132016.f11ffc8a.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007, Paul Jackson wrote:

> Argh - minor detail, but this is the first (outside of fs/proc/base.c)
> "#ifdef CONFIG_CPUSETS" in a kernel *.c file.  I prefer to avoid that.

Sorry but there will be number of those once we get the dirty writeback 
for cpusets fixed. Did you review that patchset (only internally mailed 
so far).

I do not think it makes much sense to do these macros for the single 
occurrence here and otherwise. Having the #ifdef here is much clearer.
Also the #ifdef is in already NUMA specific code.

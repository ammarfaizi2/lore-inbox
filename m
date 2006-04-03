Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWDCFZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWDCFZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbWDCFZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:25:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26340 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751532AbWDCFZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:25:24 -0400
Date: Sun, 2 Apr 2006 22:25:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: sonny@burdell.org, ak@suse.com, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
In-Reply-To: <20060402221513.96f05bdc.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
 <Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
 <20060402221513.96f05bdc.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2006, Paul Jackson wrote:

> -		for (cpu = 0; cpu < NR_CPUS; cpu++) {
> +		for_each_online_cpu(cpu) {
> 
> Idle curiosity -- what keeps a cpu from going offline during
> this scan, and leaving us with the same crash as before?

Nothing keeps a processor from going offline. We could take the hotplug 
lock for every for_each_online_cpu() in the kernel. Could you take that 
up with the hotplug folks?



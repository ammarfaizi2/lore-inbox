Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265793AbUFIQNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265793AbUFIQNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUFIQNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:13:30 -0400
Received: from ozlabs.org ([203.10.76.45]:46049 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265793AbUFIQN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:13:28 -0400
Date: Thu, 10 Jun 2004 02:12:28 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jrsantos@austin.ibm.com, mbligh@aracnet.com
Subject: Re: [PATCH] Use numa policy API for boot time policy
Message-ID: <20040609161228.GB6152@krispykreme>
References: <20040605034356.1037d299.ak@suse.de> <40C12865.9050803@colorfullife.com> <20040605041813.75e2d22d.ak@suse.de> <20040605023211.GA16084@krispykreme> <20040605122239.4a73f5e8.ak@suse.de> <20040609154429.GA6152@krispykreme> <20040609175613.487903b5.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609175613.487903b5.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> For what? 

No idea, I just want to convince myself that there arent any out there.

> IMHO 16MB hash table for a kernel structure is madness. A different data
> structure is probably needed if it's really a problem
> (is your dcache that big?). Or maybe just limit the dcache more aggressively
> to keep the max number of entries smaller.

Yep, specSFS (an NFS benchmark) shows this up quite badly. I think Jose
and Martin were looking at strategies for keeping the dcache under
control.

This was on a machine with only 64GB of RAM, if we had an NFS server
with more memory then its reasonable to want more memory dedicated to
dentries. At that point we either need to increase the hash or look at
using another structure.

Anton

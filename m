Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWHPHoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWHPHoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWHPHoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:44:21 -0400
Received: from ns1.suse.de ([195.135.220.2]:65195 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750726AbWHPHoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:44:20 -0400
Date: Wed, 16 Aug 2006 09:43:58 +0200
From: Andi Kleen <ak@muc.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
Message-Id: <20060816094358.e7006276.ak@muc.de>
In-Reply-To: <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
	<20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2. use fls to calculate array position.

I'm not sure that's a good idea. I always had my doubts that power of twos
are a good size distribution. I remember the original slab paper from Bonwick
also discouraged them. With fls you would hard code it.

I think it would be better to keep the more flexible arbitary array so that
people can try to develop new better distributions.

-Andi

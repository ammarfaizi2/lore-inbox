Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWCQRqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWCQRqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWCQRqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:46:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:21951 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030230AbWCQRqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:46:34 -0500
Date: Fri, 17 Mar 2006 09:46:29 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pradeep Vincent <pradeep.vincent@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Priority in Memory management
In-Reply-To: <9fda5f510603170037v41d273c5naf36776e6f03246e@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603170945180.9513@schroedinger.engr.sgi.com>
References: <9fda5f510603170037v41d273c5naf36776e6f03246e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2006, Pradeep Vincent wrote:

> Instead of locking out all memory, being able to set priorities for
> virtual memory regions comes across as a better idea. This way if the
> system really really needs memory, kernel can reclaim the cache pages
> but not just because somebody is writing something and it might seem
> fair to reclaim the dataset cache.

Use the zone_reclaim feature in 2.6.16. zone reclaim will remove page 
cache pages if the memory on a node gets too tight. If you are on a 
non-NUMA system then light swapping will do the same.

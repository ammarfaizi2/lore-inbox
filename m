Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWBWTYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWBWTYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWBWTYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:24:19 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15501 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751196AbWBWTYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:24:18 -0500
Date: Thu, 23 Feb 2006 11:24:03 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Christoph Lameter <clameter@engr.sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       Alok Kataria <alok.kataria@calsoftinc.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: slab: Remove SLAB_NO_REAP option
In-Reply-To: <20060223191706.GB3708@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602231123280.13800@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain>
 <20060223020957.478d4cc1.akpm@osdl.org> <Pine.LNX.4.58.0602231331530.15716@sbz-30.cs.Helsinki.FI>
 <Pine.LNX.4.64.0602230917540.1796@schroedinger.engr.sgi.com>
 <1140719812.11455.1.camel@localhost> <Pine.LNX.4.64.0602231044210.13228@schroedinger.engr.sgi.com>
 <20060223191706.GB3708@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Ravikiran G Thirumalai wrote:

> OR, introduce smartness in cache_reap to break the loop earlier if we can
> somehow dynamically recognise the cache is static. 

Right. One could inspect the sizes of the caches without taking the locks 
before committing to a real inspection under lock.

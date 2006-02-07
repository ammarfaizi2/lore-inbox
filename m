Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWBGHz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWBGHz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 02:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWBGHz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 02:55:57 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11443 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965007AbWBGHz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 02:55:56 -0500
Date: Tue, 7 Feb 2006 09:55:54 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Christoph Lameter <clameter@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       shai@scalex86.org, alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 2/3] NUMA slab locking fixes - move irq disabling from
 cahep->spinlock to l3 lock
In-Reply-To: <20060207075053.GA3664@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0602070953120.27102@sbz-30.cs.Helsinki.FI>
References: <20060203205341.GC3653@localhost.localdomain>
 <20060203140748.082c11ee.akpm@osdl.org> <Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
 <20060204010857.GG3653@localhost.localdomain> <20060204012800.GI3653@localhost.localdomain>
 <20060204014828.44792327.akpm@osdl.org> <20060206225117.GB3578@localhost.localdomain>
 <20060206153008.361202e1.akpm@osdl.org> <Pine.LNX.4.62.0602061610530.19350@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0602070925180.25555@sbz-30.cs.Helsinki.FI>
 <20060207075053.GA3664@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Ravikiran G Thirumalai wrote:
> IMHO, if you keep something around which is not needed, it might later get
> abused/misused.  And what would you add in as comments for the
> cachep->spinlock?  
> 
> Instead,  bold comments on cachep structure stating what all members are 
> protected by which lock/mutex should be sufficient no?

Yeah, I guess we can put the spinlock back if we ever need it.

			Pekka

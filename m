Return-Path: <linux-kernel-owner+w=401wt.eu-S1759486AbWLKCTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759486AbWLKCTr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 21:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762265AbWLKCTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 21:19:47 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:43064 "EHLO
	tone.orchestra.cse.unsw.EDU.AU" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759486AbWLKCTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 21:19:47 -0500
From: Paul Cameron Davies <pauld@cse.unsw.EDU.AU>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Date: Mon, 11 Dec 2006 13:19:38 +1100 (EST)
X-X-Sender: pauld@weill.orchestra.cse.unsw.EDU.AU
cc: Andrew Morton <akpm@osdl.org>, David Singleton <dsingleton@mvista.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Lee.Schermerhorn@hp.com
Subject: Re: new procfs memory analysis feature
In-Reply-To: <4579DD22.70609@goop.org>
Message-ID: <Pine.LNX.4.64.0612111315500.14977@weill.orchestra.cse.unsw.EDU.AU>
References: <45789124.1070207@mvista.com> <20061207143611.7a2925e2.akpm@osdl.org>
 <Pine.LNX.4.64.0612081716440.28861@weill.orchestra.cse.unsw.EDU.AU>
 <4579DD22.70609@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Jeremy Fitzhardinge wrote:

> I looked at implementing linear pagetable mappings for x86 as a way of
> getting rid of CONFIG_HIGHPTE, and to make pagetable manipulations
> generally more efficient.  I gave up on it after a while because all the
> existing pagetable accessors are not suitable for a linear pagetable,
> and I didn't want to have to introduce a pile of new pagetable
> interfaces.  Would the PTI interface be helpful for this?

Yes.  The PTI is a useful vehicle for experimentation with page tables.
The PTI has two components.  The first component provides for architectural
and implementation independent page table access.  The second component
provides for architecture dependendent access, but I have only done this 
for IA64.  However, abstracting out the page table implementation for the 
arch dependent stuff on x86 would enable experimentation with
implementing linear page table mappings for x86, while leaving
the current implementation in place as an alternative page table.

Cheers

Paul Davies

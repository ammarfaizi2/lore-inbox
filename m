Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWBGQuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWBGQuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWBGQuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:50:05 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:27268 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932255AbWBGQuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:50:04 -0500
Date: Tue, 7 Feb 2006 08:49:48 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Bharata B Rao <bharata@in.ibm.com>
cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <20060207055955.GB18917@in.ibm.com>
Message-ID: <Pine.LNX.4.62.0602070848450.24487@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com> <200602061931.13953.ak@suse.de>
 <Pine.LNX.4.62.0602061043440.16829@schroedinger.engr.sgi.com>
 <200602061955.19702.ak@suse.de> <20060207055955.GB18917@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Bharata B Rao wrote:

> I can still crash my x86_64 box with Christoph's program.

So it looks like the problem is arch specific. Test program runs fine on 
ia64.

> page = 0xffffffffffffffd8
> &page->lru = 0000000000000000

Yup lru field overwritten as I thought.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWBWQs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWBWQs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWBWQs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:48:59 -0500
Received: from ns2.suse.de ([195.135.220.15]:24776 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750801AbWBWQs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:48:58 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Date: Thu, 23 Feb 2006 17:48:50 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       mingo@elte.hu
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org>
In-Reply-To: <1140713001.4672.73.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602231748.50610.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 17:43, Arjan van de Ven wrote:
> On Thu, 2006-02-23 at 17:00 +0100, Andi Kleen wrote:
> > On Thursday 23 February 2006 16:09, Arjan van de Ven wrote:
> > 
> > > This patch puts the infrastructure in place to allow for a reordering of
> > > functions based inside the vmlinux. The general idea is that it is possible
> > > to put all "common" functions into the first 2Mb of the code, so that they
> > > are covered by one TLB entry. This as opposed to the current situation where
> > > a typical vmlinux covers about 3.5Mb (on x86-64) and thus 2 TLB entries.
> > > (This patch depends on the previous patch to pin head.S as first in the order)
> > 
> > I think you would first need to move the code first for that. Currently it starts
> > at 1MB, which means 1MB is already wasted of the aligned 2MB TLB entry.
> > 
> > I wouldn't have a problem with moving the 64bit kernel to 2MB though.
> 
> that was easy since it's a Config entry already ;)


I assume you boot tested it?

-Andi

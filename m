Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWCWVwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWCWVwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWCWVwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:52:11 -0500
Received: from ns2.suse.de ([195.135.220.15]:18908 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964961AbWCWVwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:52:10 -0500
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH 2/3] x86-64: Calgary IOMMU - Calgary specific bits
Date: Thu, 23 Mar 2006 22:52:01 +0100
User-Agent: KMail/1.9.1
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@us.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
References: <20060320084848.GA21729@granada.merseine.nu> <20060323190334.GD25830@rhun.haifa.ibm.com> <20060323214507.GE25830@rhun.haifa.ibm.com>
In-Reply-To: <20060323214507.GE25830@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603232252.02014.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 22:45, Muli Ben-Yehuda wrote:
> On Thu, Mar 23, 2006 at 09:03:34PM +0200, Muli Ben-Yehuda wrote:
> 
> > > > X works :-) 
> > > 
> > > So it's behind a bridge that doesn't have an IOMMU?
> > 
> > No, it's behind a bridge that does have an IOMMU and is running with
> > translation enabled (it's on PHB 0 on this machine). I guess you are
> > concerned with userspace access to the graphics controller directly,
> > without a kernel driver having set up mapping previously? I will look
> > into it but emprirically X works so either userspace is not triggering
> > DMAs or the mappings have been set up by a driver.
> 
> Turns out that X does work on my machine (SLES 9SP2) but dies with a
> bad translation error on Jon's machine, which is otherwise identical
> except it runs gentoo. We are thinking how to best address this (add
> IOMMU aware drivers to X? *shudder*), but will disable translation by
> default on PHB 0 in the mean time for a friendlier user
> experience.

You could just enable it for mmaps on /dev/mem. 

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUIPSzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUIPSzG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUIPSu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:50:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28344 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268304AbUIPSrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:47:15 -0400
Date: Thu, 16 Sep 2004 11:46:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Jesse Barnes <jbarnes@engr.sgi.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-kernel@vger.kernel.org, Bob Picco <Robert.Picco@hp.com>,
       venkatesh.pallipadi@intel.com
Subject: Re: device driver for the SGI system clock, mmtimer
In-Reply-To: <20040916181426.GA5052@ucw.cz>
Message-ID: <Pine.LNX.4.58.0409161142570.7453@schroedinger.engr.sgi.com>
References: <200409161003.39258.bjorn.helgaas@hp.com> <200409160909.12840.jbarnes@engr.sgi.com>
 <20040916181426.GA5052@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Vojtech Pavlik wrote:
> mmtimer and hpet are the same hardware actually, just a different
> specification revision, hpet being the newer one.

Its basically the same software API but different hardware. But
I would actually welcome a driver integration. If you would be willing to
let me wedge the mmtimer specifics into the hpet.c driver ;-). I would
insist though that the way mmtimer maps its timer to userspace
be also supported by the hpet driver and that you will not insist on
preserving the current memory layout of the userspace mapping for hpet.
The rest of the API could be shared to large extend.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVBPBEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVBPBEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVBPBEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:04:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:36495 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261763AbVBPBEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:04:37 -0500
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200502151557.06049.jbarnes@sgi.com>
References: <200502151557.06049.jbarnes@sgi.com>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 12:03:37 +1100
Message-Id: <1108515817.13375.63.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 15:57 -0800, Jesse Barnes wrote:
> Both the r128 and radeon drivers complain if they don't find an x86 option ROM 
> on the device they're talking to.  This would be fine, except that the 
> message is incorrect--not all option ROMs are required to be x86 based.  This 
> small patch just removes the messages altogether, causing the drivers to 
> *silently* fall back to the non-x86 option ROM behavior (it works fine and 
> there's no cause for alarm).

What about printing "No PCI ROM detected" ? I like having that info when
getting user reports, but I agree that a less worrying message would
be good.

Ben.



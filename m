Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270334AbUJTWgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270334AbUJTWgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269160AbUJTWdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:33:49 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:31250 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S270334AbUJTWIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:08:18 -0400
Date: Wed, 20 Oct 2004 23:07:55 +0100
From: Dave Jones <davej@redhat.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Hanna Linder <hannal@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com
Subject: Re: [KJ] [RFT 2.6] generic.c: replace pci_find_device with pci_get_device
Message-ID: <20041020220755.GA12553@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matthew Wilcox <matthew@wil.cx>, Hanna Linder <hannal@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	kernel-janitors <kernel-janitors@lists.osdl.org>, greg@kroah.com
References: <17100000.1098298277@w-hlinder.beaverton.ibm.com> <20041020220242.GY16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020220242.GY16153@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 11:02:42PM +0100, Matthew Wilcox wrote:
 > On Wed, Oct 20, 2004 at 11:51:17AM -0700, Hanna Linder wrote:
 > > As pci_find_device is going away soon I have converted this file to use
 > > pci_get_device instead. I have compile tested it. If anyone has this hardware
 > > and could test it that would be great.
 > 
 > Looks to me like this is a broken interface.  We almost certainly want to
 > pass the agp_device to agp_collect_device_status and agp_device_command,
 > as noted in the comment to agp_collect_device_status.  DaveJ?

It ain't pretty, but I probably won't find time to clean that up
any time soon.  This doesn't impact Hanna's patch however.

		Dave


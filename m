Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbWBHPpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWBHPpo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWBHPpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:45:44 -0500
Received: from mail.suse.de ([195.135.220.2]:50832 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030477AbWBHPpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:45:43 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Date: Wed, 8 Feb 2006 16:45:24 +0100
User-Agent: KMail/1.8.2
Cc: Bharata B Rao <bharata@in.ibm.com>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20060205163618.GB21972@in.ibm.com> <20060208121000.GA9906@in.ibm.com> <Pine.LNX.4.62.0602080736510.908@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602080736510.908@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081645.24733.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 16:42, Christoph Lameter wrote:

> However, this has implications for policy_zone. This variable should store
> the zone that policies apply to. However, in your case this zone will vary 
> which may lead to all sorts of weird behavior even if we fix 
> bind_zonelist. To which zone does policy apply? ZONE_NORMAL or ZONE_DMA32?

It really needs to apply to both (currently you can't police 4GB of your 
memory on x86-64) But I haven't worked out a good design how to implement it yet.

-Andi


> 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVK3VBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVK3VBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVK3VBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:01:00 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:45768 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1750717AbVK3VBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:01:00 -0500
Date: Wed, 30 Nov 2005 23:02:23 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Luke-Jr <luke-jr@utopios.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.x] prevent emulated SCSI hosts from wasting DMA memory
Message-ID: <20051130210222.GA32431@localdomain>
References: <20051130171520.GB15505@localdomain> <200511301933.48668.luke-jr@utopios.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511301933.48668.luke-jr@utopios.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 07:33:47PM +0000, Luke-Jr wrote:
> On Wednesday 30 November 2005 17:15, Dan Aloni wrote:
> > Emulated scsi hosts don't do DMA, so don't unnecessarily increase
> > the SCSI DMA pool.
> 
> They don't? Recently I learned(?) that apparently using hdparm -d on the 
> old /dev/hdX device still worked/applied when using ide-scsi... or do 
> "emulated scsi hosts" refer to something else?

Actually by 'do DMA' I meant use the scsi_malloc() interface - which 
is mostly used by low level drivers. The IDE drivers allocate their
DMA memory outside the SCSI layer. iSCSI hosts for instance, don't 
need to cause unnecessary DMA allocations.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net

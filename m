Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbUKLA2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbUKLA2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUKLAOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:14:07 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:47879 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S262435AbUKLANs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:13:48 -0500
Date: Thu, 11 Nov 2004 18:13:37 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Terence Ripperda <tripperda@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] VM accounting change
Message-ID: <20041112001337.GR1740@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20041111223245.GA15759@hygelac> <20041111150710.6855398a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111150710.6855398a.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.7 
X-OriginalArrivalTime: 12 Nov 2004 00:13:37.0905 (UTC) FILETIME=[74FD6610:01C4C84C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 03:07:10PM -0800, akpm@osdl.org wrote:
> VM_LOCKED|VM_IO doesn't seem to be a sane combination.  VM_LOCKED means
> "don't page it out" and VM_IO means "an IO region".  The kernel never even
> attempts to page out IO regions because they don't have reverse mappings. 
> Heck, they don't even have pageframes.
> 
> How about you drop the VM_LOCKED?

sounds good, I can do that.

on a related note, there are a couple of flags that I'm not 100% clear
on the difference between, mainly:

VM_LOCKED
PG_locked
PG_reserved

everything I've seen in the past has suggested that drivers set the
PG_reserved flag for memory allocations intended to be locked down in
memory for extensive dma (the bttv driver had always been pointed to
as an example of that).

I'm not clear how that differs from PG_locked and VM_LOCKED. is
PG_reserved still the suggested way to properly lock memory down, or
is there a more generally accepted method?

Thanks,
Terence



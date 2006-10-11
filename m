Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWJKLYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWJKLYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 07:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWJKLYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 07:24:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20608 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030333AbWJKLYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 07:24:43 -0400
Date: Wed, 11 Oct 2006 13:24:36 +0200
From: Nick Piggin <npiggin@suse.de>
To: Thomas Hellstrom <thomas@tungstengraphics.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/5] mm: add vm_insert_pfn helpler
Message-ID: <20061011112436.GA6835@wotan.suse.de>
References: <20061010121314.19693.75503.sendpatchset@linux.site> <20061010121357.19693.7339.sendpatchset@linux.site> <452CC383.4050401@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452CC383.4050401@tungstengraphics.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 12:12:19PM +0200, Thomas Hellstrom wrote:
> Nick, I just realized: would it be possible to have a pgprot_t argument 
> to this one, instead of it using vma->vm_pgprot?
> 
> The motivation for this (DRM again) is that some architectures (powerpc) 
> cannot map the AGP aperture through IO space, but needs to remap the 
> page from memory with a nocache attribute set. Others need special 
> pgprot settings for write-combined mappings.
> 
> Now, there's a possibility to change vma->vm_pgprot during the first 
> ->fault(), but again, we only have the mmap_sem in read mode.

I don't see a problem with that. It would be nice if vm_pgprot could
be kept in synch with the pte protections, but I guess a crazy
driver should be allowed to do anything it wants ;)



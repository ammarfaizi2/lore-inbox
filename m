Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWEMPcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWEMPcf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWEMPce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:32:34 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:44508 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1751329AbWEMPce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:32:34 -0400
Date: Sat, 13 May 2006 17:32:31 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages. (might be dm related)
Message-ID: <20060513153231.GA6277@uio.no>
References: <1060420062955.7727@suse.de> <20060420003839.1a41c36f.akpm@osdl.org> <20060426204809.GA15462@uio.no> <20060426135809.10a37ec3.akpm@osdl.org> <20060513134908.GA4480@uio.no> <20060513073344.4fcbc46b.akpm@osdl.org> <20060513144334.GA6013@uio.no> <20060513075147.423d18bd.akpm@osdl.org> <20060513150003.GA6096@uio.no> <20060513082409.4d173ccc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060513082409.4d173ccc.akpm@osdl.org>
X-Operating-System: Linux 2.6.16.11 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 08:24:09AM -0700, Andrew Morton wrote:
> (for dm-devel: 2.6.15.4 runs OK on this machine with the same config) (yes?)

I can't really assert that; it doesn't _seem_ to be bothered the same way,
but I've only run it for an hour or so to compile the other kernels.

Just to be 100% sure it's not overheating or such, I've turned off all fan
control in the BIOS. But then again, overheating sounds really far off; the
machine is in a cooled server room (20 degrees Celsius), and has lots of fans
making sure the air flow is good.

> Which patch?  remove-softlockup-from-invalidate_mapping_pages.patch?  No,
> that won't have caused this.  But then, it's not really obvious what this
> crash is.

OK.

> Which kind of implies that we passed a null (or very small small) `struct
> kmem_cache' pointer into kmem_cache_free().  But that doesn't seem like the
> sort of thing which will take hours to reproduce.
> 
> Do you have CONFIG_NUMA set?

Hm, yes, for some reason CONFIG_NUMA, CONFIG_K8_NUMA and
CONFIG_x86_64_ACPI_NUMA are all set; I guess they're left from the stock
config I use at a base. (For those tuning in; this is a dual-core amd64. That
might be relevant somehow.)

/* Steinar */
-- 
Homepage: http://www.sesse.net/

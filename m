Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWEYPEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWEYPEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 11:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWEYPEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 11:04:46 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4541 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965196AbWEYPEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 11:04:45 -0400
Date: Thu, 25 May 2006 08:02:24 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Shaohua Li <shaohua.li@intel.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tigran Aivazian <tigran@veritas.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       "Van De Ven, Adriaan" <adriaan.van.de.ven@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] microcode update driver rewrite
Message-ID: <20060525150224.GB1428@kroah.com>
References: <1148529049.32046.103.camel@sli10-desk.sh.intel.com> <20060525040557.GA30175@kroah.com> <20060525041234.GA22024@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525041234.GA22024@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 12:12:34AM -0400, Dave Jones wrote:
> On Wed, May 24, 2006 at 09:05:57PM -0700, Greg Kroah-Hartman wrote:
> 
>  > Don't use request_firmware, use request_firmware_nowait() instead.  That
>  > way you never stall.  You only want to update the firmware when
>  > userspace tells you to, not for every boot like I think this will do.
> 
> But the CPU microcode *does* need reloading on each boot, as it's stored
> in volatile memory that goes away on reboot.

Sorry about that, you are right.  But this will make the boot process a
bit different than what it currently is, just make sure that the distros
realize this change...

thanks,

greg k-h

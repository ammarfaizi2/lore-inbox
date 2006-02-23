Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWBWU0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWBWU0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWBWU0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:26:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19871 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932110AbWBWU0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:26:54 -0500
Date: Thu, 23 Feb 2006 15:26:39 -0500
From: Dave Jones <davej@redhat.com>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Message-ID: <20060223202638.GD6213@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Rene Herman <rene.herman@keyaccess.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <1140707358.4672.67.camel@laptopd505.fenrus.org> <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org> <43FE0B9A.40209@keyaccess.nl> <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org> <43FE1764.6000300@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FE1764.6000300@keyaccess.nl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 09:13:24PM +0100, Rene Herman wrote:
 > Linus Torvalds wrote:
 > 
 > >If you want to boot a 4MB machine with the suggested patch, you'd 
 > >have to enable CONFIG_EMBEDDED (something you'd likely want to do 
 > >anyway, for 4M machine), and turn the physical start address back
 > >down to 1MB.
 > 
 > Okay. I suppose the only other option is to make "physical_start" a 
 > variable passed in by the bootloader so that it could make a runtime 
 > decision? Ie, place us at min(top_of_mem, 4G) if it cared to. I just 
 > grepped for PHYSICAL_START and this didn't look _too_ bad.
 > 
 > I'm out of my league here though -- if I remember correctly from some 
 > reading of the early bootcode I once did, the kernel set up some 
 > temporary tables first to only cover the first few MB? If so, then I 
 > guess it would be a significant change.
 > 
 > Seems a bit cleaner though than just hardcoding the address.

the kdump people were looking at making the kernel runtime relocatable
at one point, which with my distro-vendor hat on, would be useful
as it'd mean we could use the same kernel image for normal boot, and
also for the 'kdump kernel'  (Right now, we ship another set of
kernels for each arch with a different PHYSICAL_START).
(You wouldn't believe how much grief we get from the installer folks
 for adding another set of kernel images to the ISOs).

I think that work stalled a while back though.

		Dave


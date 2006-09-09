Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWIIM60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWIIM60 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 08:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWIIM60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 08:58:26 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:32875 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932140AbWIIM60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 08:58:26 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=cVKl+EcI9ctyNoXbCFTZCZw//D3WT788nLDZx3wAOYpSAiqKUjWl9Kgnxy+GuAeTon4E2AO059OfFoNkRK/C8KhUh56PsXPOawGs+uYtrXt/H17WiygIFqGQtsW+r4Ql;
X-IronPort-AV: i="4.09,135,1157346000"; 
   d="scan'208"; a="77484169:sNHT16836246"
Date: Sat, 9 Sep 2006 07:58:27 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Martin Mares <mj@ucw.cz>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: State of the Linux PCI Subsystem for 2.6.18-rc6
Message-ID: <20060909125827.GA16084@lists.us.dell.com>
References: <20060909081816.GA13058@kroah.com> <mj+md-20060909.082546.5026.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mj+md-20060909.082546.5026.albireo@ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 10:39:32AM +0200, Martin Mares wrote:
> Hi Greg!
> 
> > No other new PCI driver API changes are pending that I am aware of.  The
> > PCI sort order change will affect some people's userspace ordering of
> > network devices, restoring it to the proper 2.4 ordering.  It was never
> > intended that this be broken, and since no one has noticed this for the
> > past 3 years, it was not broken in a severe way.
> 
> Changing the device order in the middle of the 2.6 cycle doesn't sound
> like a sane idea to me. Many people have changed their systems' configuration
> to adapt to the 2.6 ordering and this patch would break their setups.
> I have seen many such examples in my vicinity.
> 
> I believe that not breaking existing 2.6 setups is much more important
> than keeping compatibility with 2.4 kernels, especially when the problem
> is discovered after more than 2 years after release of the first 2.6.

Respectfully, With the current 2.6 development model (i.e. the lack of
a 2.7), how are we to address this kind of thing?  I'd like to see it
fixed in all new distro releases that base on 2.6.18-2.6.19, and it'll be an
individual distro decision to apply to existing releases (somewhat
unlikely).  I'm open to suggestions.  Udev rules like what opensuse
use would keep the existing names constant, as would the Red Hat
ifcfg-eth* method, so at least those distro users are OK.  We really
need this at install time to get the naming right in the first place.


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVCKAkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVCKAkA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVCKAhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:37:48 -0500
Received: from ozlabs.org ([203.10.76.45]:2526 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262806AbVCKAgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 19:36:22 -0500
Date: Fri, 11 Mar 2005 11:11:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ingo Oeser <ioe-lkml@axxeo.de>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Allow emulation of mfpvr on ppc64 kernel
Message-ID: <20050311001120.GA6512@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Ingo Oeser <ioe-lkml@axxeo.de>, Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
References: <20050310021848.GD30435@localhost.localdomain> <200503102317.04027.ioe-lkml@axxeo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503102317.04027.ioe-lkml@axxeo.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 11:17:03PM +0100, Ingo Oeser wrote:
> David Gibson wrote:
> > Andrew, please apply.
> >
> > Allow userspace programs on ppc64 to use the (privileged) mfpvr
> > instruction to determine the processor type.  At the moment it
> > emulates the instruction to provide the real PVR value, though it
> > could be made to lie in future if for some reason we wish to restrict
> > what CPU features userspace uses.
> 
> Why not putting the required information into the AUX table
> when executing your ELF programs? I loved this feature in the
> ix86 arch.

Because this is easy and is the way we already do it on ppc32..?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson

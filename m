Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWATGOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWATGOG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWATGOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:14:05 -0500
Received: from colin.muc.de ([193.149.48.1]:14092 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030400AbWATGOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:14:04 -0500
Date: 20 Jan 2006 07:13:57 +0100
Date: Fri, 20 Jan 2006 07:13:57 +0100
From: Andi Kleen <ak@muc.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, tony.luck@intel.com
Subject: Re: [PATCH] CONFIG_UNWIND_INFO
Message-ID: <20060120061357.GA62569@muc.de>
References: <4370AF4A.76F0.0078.0@novell.com> <20060114045635.1462fb9e.akpm@osdl.org> <17358.11049.367188.552649@cargo.ozlabs.ibm.com> <20060118151816.GA82365@muc.de> <17360.27469.840898.303811@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17360.27469.840898.303811@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 03:47:09PM +1100, Paul Mackerras wrote:
> Andi Kleen writes:
> 
> > The module loader should be discarding these sections on most architectures
> > because there is nothing that needs them and it's just a waste of memory
> > to store them.
> 
> Apparently the module loader loads all sections marked SHF_ALLOC,
> reasonably enough.
> 
> Why would we want the unwind tables in the .ko but not in kernel
> memory?  Isn't the point of this so that we can add an in-kernel
> unwinder?

For most people so far it was for kgdb where they would be needed
on disk only.

-Andi

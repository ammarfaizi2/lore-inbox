Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267988AbTB1PxZ>; Fri, 28 Feb 2003 10:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267991AbTB1PxZ>; Fri, 28 Feb 2003 10:53:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39946 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267988AbTB1PxY>; Fri, 28 Feb 2003 10:53:24 -0500
Date: Fri, 28 Feb 2003 16:03:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Eli Carter <eli.carter@inet.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030228160337.A31251@flint.arm.linux.org.uk>
Mail-Followup-To: Eli Carter <eli.carter@inet.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Jeff Garzik <jgarzik@pobox.com>, Andi Kleen <ak@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Matthew Wilcox <willy@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73heao7ph2.fsf@amdsimf.suse.de> <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk> <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk> <1046447737.16599.83.camel@irongate.swansea.linux.org.uk> <20030228145614.GA27798@wotan.suse.de> <20030228152502.GA32449@gtf.org> <10490000.1046446480@[10.10.2.4]> <3E5F84FE.1050409@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E5F84FE.1050409@inet.com>; from eli.carter@inet.com on Fri, Feb 28, 2003 at 09:49:18AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 09:49:18AM -0600, Eli Carter wrote:
> To do it properly, I think you'd need to give a range, not just an upper 
> bound.  On some ARM / XScale systems, you can specify a window of your 
> RAM that is visible on the PCI bus.  That may be a case too odd to care 
> about, but I'm going to have to at some point in the future....

Which may not start at address zero either.

There are even ARM systems where it'd be useful to be able to say "only
allocate memory in region N where N = first 1MB of every 2MB region.
(Yes, I know, this broken hardware should die, but it just isn't going
away thanks to the marketing powers of large IC manufacturers.)

Maybe the generic solution could be something like the resource allocation
functions which are passed an alignment function?  /me hides.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


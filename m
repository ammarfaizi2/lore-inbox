Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbTIDHcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264784AbTIDHat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:30:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63498 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264812AbTIDHaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:30:17 -0400
Date: Thu, 4 Sep 2003 08:30:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904083007.B2473@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org> <20030904071334.GA14426@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904071334.GA14426@lst.de>; from hch@lst.de on Thu, Sep 04, 2003 at 09:13:34AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 09:13:34AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 04, 2003 at 10:33:57AM +1000, Paul Mackerras wrote:
> > I don't see why this is a problem.  The change is compatible with the
> > existing uses.  We need to be able to map 36-bit physical addresses on
> > 44x.  What we really need now is 64-bit start/end values in struct
> > resource.
> 
> Then add the phys_addr_t to all places where we deal with physical
> addresses, even if it's typedef'ed to unsigned long on all other
> arches and sane ppcs.

But phys_addr_t in struct resource and being passed into ioremap is
confusing.  Apparantly, it isn't a physical address, but a platform
defined cookie which just happens to look like a physical address.

(or are we finally going to admit that it is a physical address?)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


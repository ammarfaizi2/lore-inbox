Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUCSPgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 10:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUCSPgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 10:36:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62993 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263020AbUCSPgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 10:36:47 -0500
Date: Fri, 19 Mar 2004 15:36:39 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Greg KH <greg@kroah.com>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [2/3] Use insert_resource in pci_claim_resource
Message-ID: <20040319153639.E14431@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
	Greg KH <greg@kroah.com>, David Mosberger <davidm@hpl.hp.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk> <20040318235217.GJ25059@parcelfarce.linux.theplanet.co.uk> <20040319095600.A9678@flint.arm.linux.org.uk> <20040319145212.GN25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040319145212.GN25059@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Fri, Mar 19, 2004 at 02:52:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 02:52:12PM +0000, Matthew Wilcox wrote:
> But I do think insert_resource is the right call to make.  If the device has
> the wrong resources, that means something's gone awfully wrong earlier in
> the pci code.

Sure, but due to the request_resource semantics, it provides a good way
to catch this should it occur.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

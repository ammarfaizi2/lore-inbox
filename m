Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932232AbWFDLUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWFDLUm (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 07:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWFDLUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 07:20:42 -0400
Received: from ozlabs.org ([203.10.76.45]:46025 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932232AbWFDLUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 07:20:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17538.49656.797376.483713@cargo.ozlabs.ibm.com>
Date: Sun, 4 Jun 2006 21:20:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ryan Lortie <desrt@desrt.ca>, linux-kernel@vger.kernel.org,
        mjg59@srcf.ucam.org, bcollins@ubuntu.com, Greg KH <greg@kroah.com>
Subject: Re: pci_restore_state
In-Reply-To: <20060604032746.a5b3e2dd.akpm@osdl.org>
References: <1149416010.30767.14.camel@moonpix.desrt.ca>
	<20060604032746.a5b3e2dd.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> On Sun, 04 Jun 2006 06:13:30 -0400
> Ryan Lortie <desrt@desrt.ca> wrote:
> > If I reverse the for loop to start from 15 and count down to 0, then the
> > majority of the configuration space is filled in _before_ the command
> > word is modified.  No crash.
> 
> We have a patch pending which will do that.
> 
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-03-pci/pci-reverse-pci-config-space-restore-order.patch

We really shouldn't be writing to the BIST register, at least...

Also, I don't quite see the point of writing to the read-only
registers such as vendor and device ID.

Paul.

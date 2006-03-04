Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWCDA7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWCDA7v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWCDA7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:59:50 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:24782
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751697AbWCDA7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:59:50 -0500
Date: Fri, 3 Mar 2006 16:59:35 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: removal of EXPORT_SYMBOL(insert_resource)?
Message-ID: <20060304005935.GA27548@kroah.com>
References: <Pine.LNX.4.44.0603021316001.307-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0603021316001.307-100000@gate.crashing.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 01:31:08PM -0600, Kumar Gala wrote:
> I have a situation that I believe warrants leaving insert_resource as an 
> exported API.
> 
> I've got a bus implementation that it done as a module.  While I'm more 
> than happy to provide this bus implementation to be included in the 
> mainline, I dont think it makes much sense to do so.  The code is only 
> useful to an extremely small handful of people.  If we want to clutter the 
> kernel with it I'm happy to provide a patch for it.

Please do, keeping code outside the kernel makes it _very_ hard on you.
It makes it easier if everything is in-the-tree, as you know.

Hell, we have two whole x86 subarchs with only 4 machines each in
existance, a simple bus is nothing :)

> The situation I have is a FPGA connect over PCI.  The FPGA implements a 
> number of different "functions" but uses PCI more like an SoC bus than a 
> true PCI device.  Anyways, in some discussions with gregkh, it was 
> suggested the best thing was to create a new bus type that the "fpga" 
> drivers would bind to.
> 
> I use insert_resource to handle registering the MMIO regions for each 
> device (similar to how platform devices are registered).

All the better reason to get it into the tree...

thanks,

greg k-h

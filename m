Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWBUTS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWBUTS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 14:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWBUTS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 14:18:57 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:40385
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932319AbWBUTS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 14:18:56 -0500
Date: Tue, 21 Feb 2006 11:18:57 -0800
From: Greg KH <greg@kroah.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       stathis@ims.tuwien.ac.at, l.schimmer@cgv.tugraz.at
Subject: Re: MMCONFIG broken on Tyan K8WE [was: Fusion MPT driver does not detect controller]
Message-ID: <20060221191857.GA6610@kroah.com>
References: <200602211208.38777.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602211208.38777.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 12:08:38PM -0700, Bjorn Helgaas wrote:
> This 2.6.15.4 bug is languishing in bugzilla:
> 
>     http://bugzilla.kernel.org/show_bug.cgi?id=6060
> 
> Devices behind a PCI-X bridge are invisible unless the submitter
> uses "pci=nommconf".  The devices worked in 2.6.13.5, because we
> always disabled mmconfig for AMD CPUs then.  But now it's broken.

It should have been assigned to the pci subsystem, then it would not be
languishing :)

I've fixed that.

We have a patch in the latest -mm that should take care of this issue.

thanks,

greg k-h

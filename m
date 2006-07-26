Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWGZL3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWGZL3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWGZL3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:29:50 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:35245 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751382AbWGZL3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:29:49 -0400
Date: Wed, 26 Jul 2006 05:29:48 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <gregkh@suse.de>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060726112948.GA13490@parisc-linux.org>
References: <20060725203028.GA1270@kroah.com> <44C6B881.7030901@s5r6.in-berlin.de> <20060726073132.GE6249@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726073132.GE6249@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 12:31:32AM -0700, Greg KH wrote:
> I don't know enough about SCSI to say if this driver core patch will
> help them out or not.  At first glance it does, but the device order
> gets all messed up from what users are traditionally used to, so perhaps
> the scsi core will just have to stick with their own changes.

Right.  Networking is in the same boat ... unless they're using udev
or some other tool which renames network interfaces.  I'm not entirely
comfortable with the kernel forcing you to use some other tool in order
to maintain stable device names on a static setup.  Perhaps we need
either a CONFIG option or a boot option to decide whether to do parallel
pci probes.

I still think we need a method of renaming block devices, but haven't
looked into it in enough detail yet.

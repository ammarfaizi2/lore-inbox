Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269082AbUIYHiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269082AbUIYHiX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269256AbUIYHiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:38:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50152 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269082AbUIYHiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:38:21 -0400
Date: Sat, 25 Sep 2004 08:38:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: greg@kroah.com, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [RFC] put symbolic links between drivers and modules in the sysfs tree
Message-ID: <20040925073819.GT23987@parcelfarce.linux.theplanet.co.uk>
References: <1095701390.2016.34.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095701390.2016.34.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 01:29:44PM -0400, James Bottomley wrote:
> This functionality is essential for us to work out which drivers are
> supplied by which modules.  We use this in turn to work out which
> modules are necessary to find the root device (and hence what
> initrd/initramfs needs to insert).

So what will your userland code do when you run it on a system with
non-modular kernel currently running?

IOW, that's a fundamentally broken interface - you really want the same
information regardless of modular vs. built-in.

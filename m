Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266737AbUHCVC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUHCVC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266839AbUHCVC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:02:26 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:55436 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S266737AbUHCVCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:02:23 -0400
Subject: Re: [RFC] dev_acpi: device driver for userspace access to ACPI
From: Alex Williamson <alex.williamson@hp.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091558040.27397.5523.camel@nighthawk>
References: <1091552426.4981.103.camel@tdi>
	 <1091554271.27397.5327.camel@nighthawk>  <1091557050.4981.135.camel@tdi>
	 <1091558040.27397.5523.camel@nighthawk>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 03 Aug 2004 15:02:16 -0600
Message-Id: <1091566936.4981.188.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 11:34 -0700, Dave Hansen wrote:

> Instead of architecting a generic interface, might you simply exclude
> access from your driver to things that already have generic interfaces? 
> I think there are things that we exclude from /proc/device-tree on ppc64
> because there's a generic equivalent elsewhere.  
> 

   The access interfaces I'm exposing are pretty simple building block
type features.  It's a toolset to poke at namespace, not a predefined
set of device specific functions.  I'm sure you can mix them all
together and duplicate something that already exists, but trying to
kludge in limitations sounds futile and would reduce the usefulness of
the entire interface.  Besides, given a choice, I kinda doubt people are
going to choose to implement something that requires them to know about
ACPI ;^)

> There are certainly some very platform-specific things that obviously
> need to be done with direct access to the firmware, and that we don't
> want to pollute the kernel with.  Parsing some of the firmware error
> logs on ppc64 comes to mind.  You just need to be *very* careful with
> the application authors because it's such a big gun :)

   This is certainly a big gun, but in the software world, I'd rather
have a big gun available than no gun at all.  Thanks for the comments,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab


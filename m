Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUAMW5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265925AbUAMW5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:57:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12454 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265915AbUAMW4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:56:51 -0500
Date: Tue, 13 Jan 2004 22:56:46 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jure Pe??ar <pegasus@nerv.eu.org>
Cc: Scott Long <scott_long@adaptec.com>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: Proposed enhancements to MD
Message-ID: <20040113225646.GC21151@parcelfarce.linux.theplanet.co.uk>
References: <40043C75.6040100@pobox.com> <400457E3.5030602@adaptec.com> <20040113233320.23e4cfef.pegasus@nerv.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113233320.23e4cfef.pegasus@nerv.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 11:33:20PM +0100, Jure Pe??ar wrote:
> Looking at this chicken-and-egg problem of booting from an array from
> administrator's point of view ...
> 
> What do you guys think about Intel's EFI? I think it would be the most
> apropriate place to put a piece of code that would scan the disks, assemble
> any arrays and present them to the OS as bootable devices ... If we're going
> to get a common metadata layout, that would be even easier.
> 
> Thoughts?

Why bother?  We can have userland code running before any device drivers
are initialized.  And have access to
	* all normal system calls
	* normal writable filesystem already present (ramfs)
	* normal multitasking
All of that - within the heavily tested codebase; regular kernel codepaths
that are used all the time by everything.  Oh, and it's portable.

What's the benefit of doing that from EFI?  Pure masochism?

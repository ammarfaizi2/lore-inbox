Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbULUUKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbULUUKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 15:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbULUUIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 15:08:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:63976 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261644AbULUUEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 15:04:12 -0500
Date: Tue, 21 Dec 2004 12:03:33 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, torvalds@osdl.org
Subject: Re: Cleanup PCI power states
Message-ID: <20041221200333.GA9577@kroah.com>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz> <20041217220208.GA22752@kroah.com> <20041217235051.GC29084@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217235051.GC29084@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 12:50:51AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Okay, here it is, slightly expanded version. It actually makes use of
> > > newly defined type for type-checking purposes; still no code changes.
> > 
> > Alright, I've applied this, and it will show up in the next -mm release.
> > I also fixed up pci.h for when CONFIG_PCI=N due to your changed
> > functions.
> > 
> > Now, care to send patches to fix up all of the new sparse warnings in
> > the drivers/pci/* directory?
> 
> This should reduce number of warnings in pci.c. It will still warn on
> comparison (because we are using __bitwise, but in fact we want
> something like "this is unique but arithmetic is still ok"), but that
> probably needs to be fixed in sparse.
> 
> Also killed "function does not return anything" warning.
> 
> Please apply,

What kernel tree is this against?  I get rejects in the second hunk.

thanks,

greg k-h

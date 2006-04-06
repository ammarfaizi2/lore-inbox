Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWDFDzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWDFDzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 23:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWDFDzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 23:55:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:23503 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751357AbWDFDzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 23:55:04 -0400
Date: Wed, 5 Apr 2006 20:50:12 -0700
From: Greg KH <gregkh@suse.de>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: ACPI Compile error in current git (pci.h)
Message-ID: <20060406035012.GB26601@suse.de>
References: <200603241404.08109.ncunningham@cyclades.com> <200603241437.26633.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603241437.26633.ncunningham@cyclades.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 02:37:18PM +1000, Nigel Cunningham wrote:
> Hi again.
> 
> On Friday 24 March 2006 14:04, Nigel Cunningham wrote:
> > Hi.
> >
> > Current git produces the following compile error (x86_64 uniprocessor
> > compile):
> >
> > arch/x86_64/pci/mmconfig.c:152: error: conflicting types for
> > ???pci_mmcfg_init??? arch/i386/pci/pci.h:85: error: previous declaration of
> > ???pci_mmcfg_init??? was here make[1]: *** [arch/x86_64/pci/mmconfig.o] Error 1
> > make: *** [arch/x86_64/pci] Error 2
> >
> > I haven't found out yet how the i386 file is getting included, but I
> > can say that git compiled fine last night.
> 
> Got the answer to this bit - it is included via the Makefile in the directory 
> setting a -I flag, and the file including "pci.h".

Does this still happen for 2.6.17-rc1?

thanks,

greg k-h

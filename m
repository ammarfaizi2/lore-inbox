Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWCaNz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWCaNz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWCaNz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:55:59 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:46025 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751109AbWCaNz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:55:59 -0500
Date: Fri, 31 Mar 2006 06:55:57 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: Darren Jenkins <darrenrjenkins@gmail.com>,
       kernel Janitors <kernel-janitors@lists.osdl.org>,
       thomas@winischhofer.net, linux-kernel@vger.kernel.org
Subject: Re: [KJ][Patch] fix kbuild warning in sisfb.o
Message-ID: <20060331135557.GO13590@parisc-linux.org>
References: <1143810678.7834.13.camel@localhost.localdomain> <20060331132929.GE3893@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331132929.GE3893@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 03:29:29PM +0200, Adrian Bunk wrote:
> > This is caused by the 'pci_driver struct' in sis_main.c having a pointer
> > to a 'pci_device_id struct' in 'sis_main.h' that is marked as
> > __devinitdata.
> > 
> > The patch below just removes the __devinitdata annotation from the
> > 'pci_device_id struct', which seems like the best solution here.
> 
> ACK, this is a bug that should be fixed.

If it is, then Documentation/pci.txt needs to be updated:

        The struct pci_driver shouldn't be marked with any of these tags.
        The ID table array should be marked __devinitdata.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWJGFew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWJGFew (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 01:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWJGFew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 01:34:52 -0400
Received: from colo.lackof.org ([198.49.126.79]:4039 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751747AbWJGFev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:34:51 -0400
Date: Fri, 6 Oct 2006 23:34:48 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Val Henson <val_henson@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] [TULIP] Check the return value from pci_set_mwi()
Message-ID: <20061007053448.GC3314@colo.lackof.org>
References: <1160161519800-git-send-email-matthew@wil.cx> <11601615192857-git-send-email-matthew@wil.cx> <4526AB43.7030809@garzik.org> <20061006192842.GO2563@parisc-linux.org> <4526B5BD.4030809@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4526B5BD.4030809@garzik.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 03:59:57PM -0400, Jeff Garzik wrote:
> The unmodified tulip driver checks both MWI and cacheline-size because 
> one of the clones (PNIC or PNIC2) will let you set the MWI bit, but 
> hardwires cacheline size to zero.

Maybe the generic pci_set_mwi() can verify cacheline size is non-zero?
I don't think each driver should need to enforce this.

> If the arches do not behave consistently, we need to keep the check in 
> the tulip driver, to avoid incorrectly programming the csr0 MWI bit.

Why not fix the arches to be consistent?
There's alot more drivers than arches...and we have control
of the arch specific PCI support.

thanks,
grant

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266226AbUGAS52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266226AbUGAS52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 14:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUGAS52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:57:28 -0400
Received: from fmr03.intel.com ([143.183.121.5]:10903 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266232AbUGASzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:55:43 -0400
Date: Thu, 1 Jul 2004 11:53:40 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Tom L Nguyen <tom.l.nguyen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: MSI to memory?
Message-ID: <20040701115339.A4265@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <200407011215.59723.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200407011215.59723.bjorn.helgaas@hp.com>; from bjorn.helgaas@hp.com on Thu, Jul 01, 2004 at 12:15:59PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 12:15:59PM -0600, Bjorn Helgaas wrote:
> The conventional use of MSI is for a PCI adapter to generate processor
> interrupts by writing to a local APIC.  But I've seen some things

On Intel architecture at least, the MSI writes are targeted 
to the chipset (north bridge), not directly to a local APIC.
The chipset knows the special MSI address and data values 
programmed into the PCI device and interprets the data written, 
e.g.  for interrupt redirection hints.

> If so, is that a useful capability that should be exposed through
> the Linux MSI interface?

With MSI, you get a single address/data pair. So MSI interrupts
won't work unless this single entry is programmed to the 
special interrupt specific values that the chipset expects. 
With MSI-X, you get multiple address/data pairs but this is 
presumably because the device thinks it can benefit from 
multiple interrupts.

What type of usage model did you have in mind to have the 
device write to memory instead of using MSI for interrupts?

Rajesh


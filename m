Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265683AbTFSOtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 10:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265737AbTFSOtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 10:49:55 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:20942 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S265683AbTFSOty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 10:49:54 -0400
Date: Thu, 19 Jun 2003 09:03:44 -0600
From: Matthew Wilcox <willy@fc.hp.com>
To: Greg KH <greg@kroah.com>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, willy@fc.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: move pci_domain_nr() inside "#ifdef CONFIG_PCI" bracket
Message-ID: <20030619150344.GE21906@ldl.fc.hp.com>
References: <16112.54572.443092.996206@napali.hpl.hp.com> <20030618215706.GA1919@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618215706.GA1919@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 02:57:06PM -0700, Greg KH wrote:
> On Wed, Jun 18, 2003 at 02:10:04PM -0700, David Mosberger wrote:
> > Trivial build fix: pci_domain_nr() cannot be declared unless
> > CONFIG_PCI is defined (otherwise, struct pci_bus hasn't been defined).
> 
> Thanks, I've added this to my pci bk tree and will send it off to Linus
> in a bit.

I don't understand.  One of the PPC guys saw it too, but how is it
possible?  CONFIG_PCI is first mentioned at line 526 of pci.h.
pci_bus is defined at line 446.

-- 
It's always legal to use Linux (TM) systems
http://www.gnu.org/philosophy/why-free.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSLFS2d>; Fri, 6 Dec 2002 13:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSLFS2d>; Fri, 6 Dec 2002 13:28:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21777 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265321AbSLFS2c>;
	Fri, 6 Dec 2002 13:28:32 -0500
Date: Fri, 6 Dec 2002 18:36:09 +0000
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: adam@yggdrasil.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [RFC] generic device DMA implementation
Message-ID: <20021206183609.D16341@parcelfarce.linux.theplanet.co.uk>
References: <200212061619.IAA22144@baldur.yggdrasil.com> <20021206.101715.113691767.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021206.101715.113691767.davem@redhat.com>; from davem@redhat.com on Fri, Dec 06, 2002 at 10:17:15AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 10:17:15AM -0800, David S. Miller wrote:
> Specifically, it took years to get most developers confortable with
> pci_alloc_consitent() and friends.  I totally fear that asking them to
> now add cache flushing stuff to their drivers takes the complexity way
> over the edge.
> 
> Willy, these PCXS/T processors sound like a newer cpu, do you mean to
> tell me the caches are totally not coherent with device bus space?
> 
> Please elaborate, I want to learn more.

Nono, these are _old_ machines, probably stopped production round about
1995 or so.  We mentioned these briefly back in the original days of
the pci_alloc_consistent interface discussions.  These machines cannot
allocate uncached memory, nor can the peripherals snoop the CPU's cache
(or vice versa).  As I indicated to Adam, there's a fairly limited range
of devices available for these systems and there shouldn't be a huge
problem converting the few drivers we need to these interfaces.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk

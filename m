Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTEGCvE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTEGCvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:51:04 -0400
Received: from cbshost-12-155-143-237.sbcox.net ([12.155.143.237]:21207 "EHLO
	sb-lnx3.rinconnetworks.com") by vger.kernel.org with ESMTP
	id S262771AbTEGCvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 22:51:03 -0400
Date: Tue, 6 May 2003 20:08:06 -0700
From: Paul van Gool <paul.vangool@rinconnetworks.com>
To: Paul Mundt <lethal@stampede.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Typo in arch/sh/kernel/io_7751se.c
Message-ID: <20030507030806.GA6347@rinconnetworks.com>
Reply-To: paul.vangool@rinconnetworks.com
References: <20030507024647.GA6303@rinconnetworks.com> <20030507024938.GA9577@stampede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030507024938.GA9577@stampede.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Paul.

Paul

On Tue, May 06, 2003 at 08:49:38PM -0600, Paul Mundt wrote:
> On Tue, May 06, 2003 at 07:46:47PM -0700, Paul van Gool wrote:
> > not sure who to send it to. So as suggested in REPORTING-BUGS, I'm sending
> > it to this mailing list.
> > 
> Please send all SH related bugs to linuxsh-dev@lists.sourceforge.net.
> Consult MAINTAINERS for additional links.
> 
> > While building a kernel for an SH7751 SolutionEngine, I ran into a link
> > problem using a non-PCI configuration. I tracked the problem back to
> > arch/sh/kernel/io_7751se.c. On line 304, I see:
> > 
> > #if defined(CONFIG_PCI)
> > #define CHECK_SH7751_PCIIO(port) \
> >   ((port >= PCIBIOS_MIN_IO) && (port < (PCIBIOS_MIN_IO + SH7751_PCI_IO_SIZE)))
> > #else
> > #define CHECK_SH_7751_PCIIO(port) (0)
> > #endif
> > 
> > The problem is with the 5th line. It should be:
> > 
> > #define CHECK_SH7751_PCIIO(port) (0)
> > 
> > I removed the '_' between SH and 7751.
> > 
> This issue has already been fixed in the LinuxSH CVS for both 2.4 and
> 2.5. Since I just synced 2.5 over, I guess its time for a 2.4 update..

-- 
Paul van Gool                                               Rincon Networks
paul.vangool@rinconnetworks.com                              (805)-705-1442

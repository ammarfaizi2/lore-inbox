Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932552AbVKWVl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVKWVl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVKWVl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:41:29 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:42900 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932551AbVKWVl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:41:27 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Dave Jones <davej@redhat.com>
Cc: gcoady@gmail.com, Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       david.fox@linspire.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2 pci_ids.h cleanup is a pain
Date: Thu, 24 Nov 2005 08:41:12 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <ppn9o111e7dbghgjn4luruvggke8r3k8u7@4ax.com>
References: <438249CB.8050200@linspire.com> <20051121224438.GA18966@kroah.com> <20051122162558.702fae4a.akpm@osdl.org> <41i7o11nbvrfrd8n2ev6kf11qjfjbil3jr@4ax.com> <20051123041917.GA27358@redhat.com>
In-Reply-To: <20051123041917.GA27358@redhat.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005 23:19:17 -0500, Dave Jones <davej@redhat.com> wrote:

>On Wed, Nov 23, 2005 at 12:51:45PM +1100, Grant Coady wrote:
> > Hi Andrew, Greg,
> > 
> > On Tue, 22 Nov 2005 16:25:58 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > 
> > >Greg KH <greg@kroah.com> wrote:
> > >>
> > >> On Mon, Nov 21, 2005 at 02:27:23PM -0800, David Fox wrote:
> > >> > I'm sure I'm not the only person that applies patches to the kernel that 
> > >> > use some of the 500 plus PCI IDS eliminated from pci_ids.h by rc2.  I 
> > >> > would like to see the PCI ids that were removed simply because the don't 
> > >> > occur in the main kernel source restored.  Is there a rationale for 
> > >> > removing them that I'm not aware of?
> > >> 
> > >> They were not being used.  Why would you want them in there?
> > >
> > >Because they contained useful information which had been accumulated by
> > >many people over a long period of time.
> > >
> > >Throwing that information away seemed rather pointless, especially as the
> > >cost of retaining it was so low.
> > 
> > There's an out-of-tree reference, the pci.ids website, that carries 
> > this information, do we need the reference info in the kernel as well?  
> > 
> > So far two people raised an objection, the other wants to maintain 
> > an out-of-tree driver, D. Fox didn't say why he needs the symbols.
>
>Three. I already mentioned we broke the compilation of the
>advansys driver because of this.

Nope, advansys.* don't appear to use PCI_*  Defines its own ASC_PCI* 
instead?

Checked:  linux-2.6.13.4, linux-2.6.15-rc2

Grant.

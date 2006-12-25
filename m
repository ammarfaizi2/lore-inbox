Return-Path: <linux-kernel-owner+w=401wt.eu-S1754268AbWLYH7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbWLYH7Q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 02:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbWLYH7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 02:59:16 -0500
Received: from colo.lackof.org ([198.49.126.79]:55129 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266AbWLYH7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 02:59:15 -0500
Date: Mon, 25 Dec 2006 00:59:12 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] Update Documentation/pci.txt v7
Message-ID: <20061225075912.GA32499@colo.lackof.org>
References: <456404E2.1060102@jp.fujitsu.com> <20061122182804.GE378@colo.lackof.org> <45663EE8.1080708@jp.fujitsu.com> <20061124051217.GB8202@colo.lackof.org> <20061206072651.GG17199@kroah.com> <20061210072508.GA12272@colo.lackof.org> <20061215170207.GB15058@kroah.com> <20061218071133.GA1738@colo.lackof.org> <20061224060726.GC24131@colo.lackof.org> <20061224111622.e22bfd8a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061224111622.e22bfd8a.randy.dunlap@oracle.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2006 at 11:16:22AM -0800, Randy Dunlap wrote:
> On Sat, 23 Dec 2006 23:07:26 -0700 Grant Grundler wrote:
> 
> > +10. Legacy I/O port free driver
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> That subject (and patches with similar subject) confuses me.
> It's difficult to associate the adjectives correctly.

Agreed. This was the original section name and I didn't
have a better idea.

> I suppose it just needs some hyphens/dashes, like:
> 
> 10. Legacy-I/O-port-free driver
> 
> but that's ETOOMUCH.  Maybe ?
> 
> 10.  Stop using legacy I/O space

Yeah, that is good too.

I changed it to "10. pci_enable_device_bars() and Legacy I/O Port space".
The goal of this section is to introduce the new PCI function 
and why one should use it.


...
> > +Thus, timing sensitive code should add readl() where the CPU is
> > +expected to wait before doing other work.  The classic "bit banging"
> > +sequence works fine for I/O Port space:
> > +
> > +       for (i=8; --i; val >>= 1) {
> 
> Please use:	i = 8;
> to match CodingStyle.  (and below)

Definitely....Sorry, I thought someone already asked me to change this.
I thought I did. Changed now in both cases.


> Rest looks good to me.

v8 will be posted shortly.

thanks Randy!
grant

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUCRRph (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbUCRRph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:45:37 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:55371 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262772AbUCRRpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:45:33 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Exporting physical topology information
Date: Thu, 18 Mar 2004 09:44:38 -0800
User-Agent: KMail/1.6.1
Cc: Martin Hicks <mort@wildopensource.com>, greg@kroah.com
References: <20040317213714.GD23195@localhost>
In-Reply-To: <20040317213714.GD23195@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403180944.38760.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 March 2004 1:37 pm, Martin Hicks wrote:
> I'm not proposing that we build an entire physical topology tree in
> sysfs, but just providing an attribute file.  The two most obvious
> examples of where this would be useful is for nodes and pci busses.  The
> Altix platform is a modular system with CPU bricks and IO bricks.  We
> currently have no method for locating where "node0" is, nor do we have a
> method for locating pci bus 0000:20, for example.

I'm curious how other arches deal with this too.  Like on ppc64 when
you want to remove a CPU or set of CPUs, you have to bring it (or all
of the cores on a given module) down via software, then go into the
lab and find the module to pull it out.  Is there a mapping somewhere
that the user is expected to use?  A hypervisor call of some sort to
make some lights blink?

> If we could physically locate a PCI bus, then it would be much easier
> to (for example) locate our defective SCSI disk that is target4 on the
> SCSI controller that is on pci bus 0000:20.

This seems like one of the main uses--find components that went bad.
Physically locating a CPU, DIMM, PCI board, or disk would all be
easier if we provided some sort of physical identifier and
logical->physical mapping information.  On IRIX, we actually expose
the whole physical hierarchy of the system in /hw.  One of the
problems with that approach is that everytime a new system
configuration is released the kernel has to be updated to know about
it, resulting in /hw paths that change over time, and from system to
system...

Jesse


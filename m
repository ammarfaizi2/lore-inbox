Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTDIQqk (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 12:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263599AbTDIQqk (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 12:46:40 -0400
Received: from toq3-srv.bellnexxia.net ([209.226.175.16]:39406 "EHLO
	toq3-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263566AbTDIQqj (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 12:46:39 -0400
Date: Wed, 9 Apr 2003 12:43:12 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Roman Zippel <zippel@linux-m68k.org>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: what means duplicate "config" entries in Kconfig file?
In-Reply-To: <Pine.LNX.4.44.0304091818470.12110-100000@serv>
Message-ID: <Pine.LNX.4.44.0304091237490.28112-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Apr 2003, Roman Zippel wrote:

> On Wed, 9 Apr 2003, Robert P. J. Day wrote:
 
> >   i'm not sure what it means to have two config entries with 
> > identical symbols.  can someone clarify this?  i'm just confused
> > (which should not come as a surprise at this point).
> 
> You can have as much entries as you want, the only limit is that you can
> only have one user prompt per config entry and the type must not conflict.
> This example could have been done with a single entry and this is usually
> prefered to keep it more compact, but you don't have to.

not to belabor this, but what does it mean when the two dependencies
are mutually exclusive, as in the example i provided:

-----------------------

config MCA
        bool "MCA support"
        depends on !(X86_VISWS || X86_VOYAGER)
        help
          MicroChannel Architecture is found in some IBM PS/2 machines and
          laptops.  It is a bus system similar to PCI or ISA. See
          <file:Documentation/mca.txt> (and especially the web page given
          there) before attempting to build an MCA bus kernel.

config MCA
        depends on X86_VOYAGER
        default y if X86_VOYAGER

---------------------

  the two options X86_VISWS and X86_VOYAGER are simple "bool"s
representing the (radio-box) subarchitecture type.

  the first seems to represent a dependency of *neither* of those
two listed options, while the second config *depends* on one of 
them.  

  how exactly do you reconcile what looks like contradictory
dependencies for the same config entry?

rday,
wondering just how badly he's embarrassing himself by now ...


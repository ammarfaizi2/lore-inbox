Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTLQRos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 12:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTLQRos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 12:44:48 -0500
Received: from rrcs-sw-24-153-196-99.biz.rr.com ([24.153.196.99]:54722 "EHLO
	obiwan.dummynet") by vger.kernel.org with ESMTP id S264488AbTLQRok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 12:44:40 -0500
Date: Wed, 17 Dec 2003 11:44:27 -0600
From: Dan Hopper <ku4nf@austin.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       vladimir.kondratiev@intel.com
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031217174427.GA31730@obiwan.dummynet>
Mail-Followup-To: Dan Hopper <ku4nf@austin.rr.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	vladimir.kondratiev@intel.com
References: <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com> <Pine.LNX.4.58.0312160844110.1599@home.osdl.org> <3FDFF81F.7040309@intel.com> <Pine.LNX.4.58.0312162240040.8541@home.osdl.org> <Pine.GSO.4.58.0312171105200.24864@waterleaf.sonytel.be> <Pine.LNX.4.58.0312170753400.8541@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312170753400.8541@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> remarked:
> 
> On Wed, 17 Dec 2003, Geert Uytterhoeven wrote:
> > 
> > For the record: PCI Express is _not_ PCI-X.
> 
> Ok, but "PCI Express" is too damn long to write, so we'll have to have 
> _some_ sane name for it without typing for half an hour.

FWIW, "PCI-E" is in common use in these parts.

Also, wrt the config space backward compatibility issue, it is my
understanding that the PCI-E root complex and PCI-E devices can be
enumerated and used successfully with no software changes, within
the constraints of PCI.  The BIOS or OS should be able to enumerate
devices, probe BARs and assign resources, perform basic error
handling, etc. without any PCI-E-specific changes. 

The hardware is required to be able to initialize PCI-E links, set
things up to sane states, and so forth without software assistance
in order to make this magic happen.  It would be interesting to hear
from Vladimir as to whether or not this is happening with his PCI-E
test system.

Having said all that, it's obviously preferable to end up with
native OS and BIOS support for the PCI-E extended configuration
space, extra error reporting mechanisms, etc.  Native PCI-E devices
hanging off the bus somewhere might not work (or, at least, work
well) with an OS that doesn't grok the PCI-E extensions.  

Dan

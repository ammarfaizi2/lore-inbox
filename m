Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161198AbWALTWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbWALTWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161199AbWALTWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:22:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:981 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161198AbWALTWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:22:05 -0500
Date: Thu, 12 Jan 2006 14:21:39 -0500
From: Dave Jones <davej@redhat.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm2
Message-ID: <20060112192139.GI19827@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
	Andrew Morton <akpm@osdl.org>
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org> <43C55148.4010706@ens-lyon.org> <20060111202957.GA3688@redhat.com> <u3bjtogq0@a1i15.kph.uni-mainz.de> <20060112171137.GA19827@redhat.com> <43C6AA17.5070409@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C6AA17.5070409@ens-lyon.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 02:12:23PM -0500, Brice Goglin wrote:
 > Dave Jones wrote:
 > 
 > >On Thu, Jan 12, 2006 at 11:58:31AM +0100, Ulrich Mueller wrote:
 > > 
 > > >    $ lspci -s 00:02.0 -v
 > > >    00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03) (prog-if 00 [VGA])
 > > >    	Subsystem: Hewlett-Packard Company nx6110/nc6120
 > > >    	Flags: bus master, fast devsel, latency 0, IRQ 16
 > > >    	Memory at d0400000 (32-bit, non-prefetchable) [size=512K]
 > > >    	I/O ports at 7000 [size=8]
 > > >    	Memory at c0000000 (32-bit, prefetchable) [size=256M]
 > > >    	Memory at d0480000 (32-bit, non-prefetchable) [size=256K]
 > > >    	Capabilities: [d0] Power Management version 2
 > >
 > >Another one that advertises no AGP capabilities.
 > >In this situation you shouldn't *need* agpgart.  If it's PCI[E],
 > >radeon will use pcigart.
 > >  
 > Is this supposed to work soon ? Looking at all "agp_foo" symbols in the
 > drm module, there might lots of work do first, right ? In this case, it
 > might be good to still be able to load agpgart on PCI-E machine for a
 > while ?

Well, mainline does that already, and this stuff won't go anywhere
near there anytime soon.  I'd like to understand why drm can't find
the symbols in the module, even though its loaded, but between being
ill this week, and trying to get the Fedora 5 test2 kernel in shape,
I've not had much chance to dig into it yet.

		Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161190AbWALTMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbWALTMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWALTMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:12:55 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:54736 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1161190AbWALTMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:12:54 -0500
Message-ID: <43C6AA17.5070409@ens-lyon.org>
Date: Thu, 12 Jan 2006 14:12:23 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org> <43C55148.4010706@ens-lyon.org> <20060111202957.GA3688@redhat.com> <u3bjtogq0@a1i15.kph.uni-mainz.de> <20060112171137.GA19827@redhat.com>
In-Reply-To: <20060112171137.GA19827@redhat.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Thu, Jan 12, 2006 at 11:58:31AM +0100, Ulrich Mueller wrote:
> 
> >    $ lspci -s 00:02.0 -v
> >    00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03) (prog-if 00 [VGA])
> >    	Subsystem: Hewlett-Packard Company nx6110/nc6120
> >    	Flags: bus master, fast devsel, latency 0, IRQ 16
> >    	Memory at d0400000 (32-bit, non-prefetchable) [size=512K]
> >    	I/O ports at 7000 [size=8]
> >    	Memory at c0000000 (32-bit, prefetchable) [size=256M]
> >    	Memory at d0480000 (32-bit, non-prefetchable) [size=256K]
> >    	Capabilities: [d0] Power Management version 2
>
>Another one that advertises no AGP capabilities.
>In this situation you shouldn't *need* agpgart.  If it's PCI[E],
>radeon will use pcigart.
>  
>
Is this supposed to work soon ? Looking at all "agp_foo" symbols in the
drm module, there might lots of work do first, right ? In this case, it
might be good to still be able to load agpgart on PCI-E machine for a
while ?

Brice


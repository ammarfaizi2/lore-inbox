Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWALRL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWALRL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWALRL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:11:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:995 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751223AbWALRLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:11:55 -0500
Date: Thu, 12 Jan 2006 12:11:37 -0500
From: Dave Jones <davej@redhat.com>
To: Ulrich Mueller <ulm@kph.uni-mainz.de>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
       Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm2
Message-ID: <20060112171137.GA19827@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ulrich Mueller <ulm@kph.uni-mainz.de>, linux-kernel@vger.kernel.org,
	Dave Airlie <airlied@linux.ie>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>
References: <20060107052221.61d0b600.akpm@osdl.org> <43C0172E.7040607@ens-lyon.org> <20060107210413.GL9402@redhat.com> <43C03214.5080201@ens-lyon.org> <43C55148.4010706@ens-lyon.org> <20060111202957.GA3688@redhat.com> <u3bjtogq0@a1i15.kph.uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u3bjtogq0@a1i15.kph.uni-mainz.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 11:58:31AM +0100, Ulrich Mueller wrote:
 
 >    $ lspci -s 00:02.0 -v
 >    00:02.0 VGA compatible controller: Intel Corporation Mobile 915GM/GMS/910GML Express Graphics Controller (rev 03) (prog-if 00 [VGA])
 >    	Subsystem: Hewlett-Packard Company nx6110/nc6120
 >    	Flags: bus master, fast devsel, latency 0, IRQ 16
 >    	Memory at d0400000 (32-bit, non-prefetchable) [size=512K]
 >    	I/O ports at 7000 [size=8]
 >    	Memory at c0000000 (32-bit, prefetchable) [size=256M]
 >    	Memory at d0480000 (32-bit, non-prefetchable) [size=256K]
 >    	Capabilities: [d0] Power Management version 2

Another one that advertises no AGP capabilities.
In this situation you shouldn't *need* agpgart.  If it's PCI[E],
radeon will use pcigart.

		Dave


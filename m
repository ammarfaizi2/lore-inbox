Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268241AbUHKVtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268241AbUHKVtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268244AbUHKVtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:49:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:4304 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268241AbUHKVtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:49:09 -0400
Date: Wed, 11 Aug 2004 14:25:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: bunk@fs.tum.de, zippel@linux-m68k.org, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
Message-Id: <20040811142546.53dc84da.rddunlap@osdl.org>
In-Reply-To: <20040811111525.GA2205@dmt.cyclades>
References: <20040809195656.GX26174@fs.tum.de>
	<20040809203840.GB19748@mars.ravnborg.org>
	<Pine.LNX.4.58.0408100130470.20634@scrub.home>
	<20040810084411.GI26174@fs.tum.de>
	<20040810211656.GA7221@mars.ravnborg.org>
	<20040811111525.GA2205@dmt.cyclades>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004 08:15:25 -0300 Marcelo Tosatti wrote:

| On Tue, Aug 10, 2004 at 11:16:57PM +0200, Sam Ravnborg wrote:
| > On Tue, Aug 10, 2004 at 10:44:11AM +0200, Adrian Bunk wrote:
| > > 
| > > I assume Sam thinks in the direction to let a symbol inherit the 
| > > dependencies off all symbols it selects.
| > > 
| > > E.g. in
| > > 
| > > config A
| > > 	depends on B
| > > 
| > > config C
| > > 	select A
| >         depends on Z
| > 
| >   config Z
| >         depends on Y
| > > 
| > > 
| > > C should be treated as if it would depend on B.
| > 
| > Correct. But at the same time I miss some functionality to
| > tell me what a given symbol:
| > 1) depends on
| > 2) selects
| > 
| > It would be nice in menuconfig to see what config symbol
| > that has dependencies and/or side effects. 
| 
| Definately agreed. Not all users want/can go and grep the source 
| tree looking for dependencies of a given 
| symbol.
| 
| Showing the dependencies on menuconfig/xconfig is a user friendly 
| feature. 

xconfig already has a way to do this.  Set all Options (5 of them,
although fewer would probably work).  menuconfig doesn't do this.

What would be even more helpful would be a way to tell *config to
jump from <current location, where a symbol is used> to
<where a symbol is defined>.

--
~Randy

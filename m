Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUHKVhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUHKVhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUHKVhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:37:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41926 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268247AbUHKVhC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:37:02 -0400
Date: Wed, 11 Aug 2004 08:15:25 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@fs.tum.de>, Roman Zippel <zippel@linux-m68k.org>,
       Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
Message-ID: <20040811111525.GA2205@dmt.cyclades>
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de> <20040810211656.GA7221@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810211656.GA7221@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 11:16:57PM +0200, Sam Ravnborg wrote:
> On Tue, Aug 10, 2004 at 10:44:11AM +0200, Adrian Bunk wrote:
> > 
> > I assume Sam thinks in the direction to let a symbol inherit the 
> > dependencies off all symbols it selects.
> > 
> > E.g. in
> > 
> > config A
> > 	depends on B
> > 
> > config C
> > 	select A
>         depends on Z
> 
>   config Z
>         depends on Y
> > 
> > 
> > C should be treated as if it would depend on B.
> 
> Correct. But at the same time I miss some functionality to
> tell me what a given symbol:
> 1) depends on
> 2) selects
> 
> It would be nice in menuconfig to see what config symbol
> that has dependencies and/or side effects. 

Definately agreed. Not all users want/can go and grep the source 
tree looking for dependencies of a given 
symbol.

Showing the dependencies on menuconfig/xconfig is a user friendly 
feature. 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWDSPx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWDSPx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWDSPx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:53:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:11757 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750951AbWDSPx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:53:26 -0400
Date: Wed, 19 Apr 2006 10:53:19 -0500
From: Robin Holt <holt@sgi.com>
To: Antti Halonen <antti.halonen@secgo.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: searching exported symbols from modules
Message-ID: <20060419155318.GA31409@lnx-holt.americas.sgi.com>
References: <963E9E15184E2648A8BBE83CF91F5FAF43619A@titanium.secgo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <963E9E15184E2648A8BBE83CF91F5FAF43619A@titanium.secgo.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 04:08:37PM +0300, Antti Halonen wrote:
> 
> Hi Dick,
> 
> Thanks for your response.
> 
> > `insmod` (or modprobe) does all this automatically. Anything that's
> > 'extern' will get resolved. You don't do anything special. You can
> > also use `depmod` to verify that you won't have any problems loading.
> > `man depmod`.
> 
> Yes, I know insmod and herein the problem lies. I have a module where
> I want to use functions provided by another module, _if_ it is present, 
> otherwise use modules internal functions. 
> 
> So if I hardcode the function calls statically in my module, the insmod
> goes trough of course, if the service module is present. But, it fails
> if it's not. 
> 
> So, I want to load up, check if the service module is present, and use
> it's servides.

xpc does something similar to this.  We have a module (xp.ko) which gets
loaded.  The client modules (xpnet.ko and xpmem.ko) register with xp.ko.
If xpc.ko is not loaded, the modules can not do any communication with
the other partitions of an SGI machine.  If xpc gets loaded, connections
are made to the other partitions and the modules begin to work across
the boundaries.

Hope that helps,
Robin Holt

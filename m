Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWJCU6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWJCU6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 16:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWJCU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 16:58:23 -0400
Received: from mail.gmx.de ([213.165.64.20]:60322 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030401AbWJCU6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 16:58:23 -0400
X-Authenticated: #20450766
Date: Tue, 3 Oct 2006 22:58:28 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: Undefined '.bus_to_virt', '.virt_to_bus' causes compile error
 on Powerpc 64-bit
In-Reply-To: <20061002234428.GE3278@stusta.de>
Message-ID: <Pine.LNX.4.60.0610032236510.3937@poirot.grange>
References: <20061002214954.GD665@shell0.pdx.osdl.net> <20061002234428.GE3278@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006, Adrian Bunk wrote:

> On Mon, Oct 02, 2006 at 02:49:54PM -0700, Judith Lebzelter wrote:
> 
> > For the automated cross-compile builds at OSDL, powerpc 64-bit 
> > 'allmodconfig' is failing.  The warnings/errors below appear in 
> > the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.
> 
> known for ages - the drivers need fixing.

...

> > WARNING: ".bus_to_virt" [drivers/scsi/tmscsim.ko] undefined!

The problem with this one is that the code path, where bus_to_virt is 
used, is only executed under some very exotic circumstances, i.e., 
is practically untestable. I'll try to cook something up for that...

Thanks
Guennadi
---
Guennadi Liakhovetski

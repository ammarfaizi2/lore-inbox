Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbTI3RSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 13:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbTI3RSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 13:18:30 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:58758 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261587AbTI3RS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 13:18:28 -0400
Date: Tue, 30 Sep 2003 19:18:21 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Michael Hunold <hunold@convergence.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE I/O disturbes other PCI busmasters on VIA platforms
Message-ID: <20030930171821.GL9523@vana.vc.cvut.cz>
References: <3F79B630.8070308@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F79B630.8070308@convergence.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 06:58:24PM +0200, Michael Hunold wrote:
> Hello all,
> 
> If you disable dma, you'll notice frozen pictures, which will last up to 
> several seconds.
> 
> I tried the following
> - use latest 2.4 kernel
> - set latencies for the different PCI devices with "setpci"
> - play with burst and threshold settings of the saa7146 busmaster
> 
> Unfortunately, non of these things really helped. I was able to make 
> things worse (by setting latencies very low or by lowering the burst 
> size of the transfers), but I did not get rid of the problem.
> 
> Does anyone know a solution for this problem? Any help is appreciated.

Do not perform busmaster transfers between busses with diffrerent speeds,
or use only 20MBps bandwidth or do not use VIA. All chips I saw from
them are not able to convert burst transfer on PCI to the burst
transfer on AGP bus. Either go through main memory, or plug PCI videocard
to your box.
						Petr Vandrovec

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271518AbTGQRW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271519AbTGQRW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:22:29 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:32007 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271518AbTGQRW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:22:27 -0400
Date: Thu, 17 Jul 2003 18:37:20 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <dank@reflexsecurity.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
In-Reply-To: <20030717170708.GB4280@suse.de>
Message-ID: <Pine.LNX.4.44.0307171834420.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > Strange that CONFIG_VT would get set to no. Another huge issue is that 
>  > people are configuring several framebuffer drivers to run the same piece 
>  > of hardware. 
> 
> A number of people seem to be seeing regressions with vesafb too.
> Configs that worked with 2.4 give a blank screen, and lock up under 2.5
> I believe vga=791 was one such option.

They are forgetting to set CONFIG_FRAMEBUFFER_CONSOLE.

P.S
   I have had VESA compiled without framebuffer console but with mdacon 
instead. If they would log in a do a cat /dev/urandom > /dev/fb0 they 
would see that the VESA fbdev driver is functional.
  


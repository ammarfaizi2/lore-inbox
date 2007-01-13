Return-Path: <linux-kernel-owner+w=401wt.eu-S1422776AbXAMUX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422776AbXAMUX1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 15:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422781AbXAMUX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 15:23:27 -0500
Received: from bill.weihenstephan.org ([82.135.35.21]:44277 "EHLO
	bill.weihenstephan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422776AbXAMUX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 15:23:26 -0500
From: Juergen Beisert <juergen127@kreuzholzen.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel command line for a specific framebuffer console driver
Date: Sat, 13 Jan 2007 21:23:23 +0100
User-Agent: KMail/1.9.4
Cc: Alexey Dobriyan <adobriyan@gmail.com>
References: <200701121343.43100.juergen127@kreuzholzen.de> <20070112193627.GA4999@martell.zuzino.mipt.ru>
In-Reply-To: <20070112193627.GA4999@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701132123.23866.juergen127@kreuzholzen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Friday 12 January 2007 20:36, Alexey Dobriyan wrote:
> On Fri, Jan 12, 2007 at 01:43:42PM +0100, Juergen Beisert wrote:
> > does someone know how to forward a kernel command line option to
> > configure the AMD Geode GX1 framebuffer?
> >
> > I tried with "video=gx1fb:1024x768-16@60" but it does not work. On
> > another machine with an SIS framebuffer the line
> > "video=sisfb:1280x1024-8@60" works as expected.
> >
> > Any ideas?
>
> Yes. You try this patch and report whether it works or not.

Thank you very much. Yes it works. I tried these kernel parameters:

1) video=gx1fb:mode:1280x1024-16@60,crt:1
  -> CRT was active, 160x64 console
2) video=gx1fb:mode:1024x768-16@60,crt:1
  -> CRT was active, 128x48 console
3) video=gx1fb:mode:800x600-16@60,crt:0,panel:800x600
  -> CRT was disabled, 100x37 console
4) video=gx1fb:mode:1024x768-16@60,crt:0,panel:800x600
  -> CRT was disabled, 80x25 console

Sorry, I have no flatpanel, so I cannot test if the "panel" option works 
correctly. But somethings changes when I tried different values (see 3 and 
4).

Regards
Juergen

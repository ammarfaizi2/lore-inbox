Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTLSQ2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTLSQ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:28:07 -0500
Received: from main.gmane.org ([80.91.224.249]:52124 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263491AbTLSQ2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:28:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: nick black <dank@suburbanjihad.net>
Subject: Re: 2.6-test11 framebuffer Matrox
Date: Fri, 19 Dec 2003 16:28:01 +0000 (UTC)
Message-ID: <brv8uh$but$1@sea.gmane.org>
References: <200312190314.13138.schwientek@web.de>
Reply-To: dank@reflexsecurity.com
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200312190314.13138.schwientek@web.de>, Steffen Schwientek wrote:
> My Matrox-framebuffer is not working properly. Build direct into the
> kernel, the monitor will be black with some stripes at startup, just the
> reset button works.
> Build as a modules, the same happens if I load the module.

I've managed to get my AGP G400 working in the following setups under
2.6.0 since -test7:

with Petr's patch, reverting to 2.4 interfaces:
  video=matroxfb:vesa:0x1bb gives me a great fbcon.  I can either use
  X's fbdev driver at the same resolution, or the mga driver at any
  resolution, with no problems.

without Petr's patch:
  video=matroxfb:vesa:0x1bb gives me a great fbcon.  I can only use
  X's fbdev driver at the same resolution; the mga driver at any
  resolution causes massive console corruption upon switching from X to
  console and causing any screen changes.  Also, I get a large white
  block underneath the logo on boot.
	
-- 
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo


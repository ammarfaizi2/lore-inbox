Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264762AbSJWL0j>; Wed, 23 Oct 2002 07:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264770AbSJWL0j>; Wed, 23 Oct 2002 07:26:39 -0400
Received: from main.gmane.org ([80.91.224.249]:22237 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S264762AbSJWL0i>;
	Wed, 23 Oct 2002 07:26:38 -0400
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: radeon framebuffer code doesn't compile (2.5.44 kernel)
Date: Wed, 23 Oct 2002 07:33:45 -0400
Message-ID: <ap61b1$v28$1@main.gmane.org>
References: <15797.64245.366204.917107@wombat.chubb.wattle.id.au>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1035372705 31816 130.127.121.177 (23 Oct 2002 11:31:45 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Wed, 23 Oct 2002 11:31:45 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

> 
> When trying to compile the radeon framebuffer code in 2.5.44 I see
> compilation errors (appended).  My guess is that it hasn't been
> updated to match the current fb.h.
> 
> 
> drivers/video/radeonfb.c:605: unknown field `fb_get_fix' specified in
> initializer drivers/video/radeonfb.c:605: warning: initialization from
> incompatible pointer type drivers/video/radeonfb.c:606: unknown field
> `fb_get_var' specified in initializer drivers/video/radeonfb.c:606:
> warning: initialization from incompatible pointer type
> drivers/video/radeonfb.c: In function `radeon_set_dispsw':
> drivers/video/radeonfb.c:1385: structure has no member named `type'
> drivers/video/radeonfb.c:1386: structure has no member named `type_aux'
> drivers/video/radeonfb.c:1387: structure has no member named `ypanstep'
> drivers/video/radeonfb.c:1388: structure has no member named `ywrapstep'
> drivers/video/radeonfb.c:1397: structure has no member named `visual'
> drivers/video/radeonfb.c:1398: structure has no member named `line_length'
> drivers/video/radeonfb.c:1405: structure has no member named `visual'
> drivers/video/radeonfb.c:1406: structure has no member named `line_length'
> drivers/video/radeonfb.c:1413: structure has no member named `visual'
> drivers/video/radeonfb.c:1414: structure has no member named `line_length'
> drivers/video/radeonfb.c:1421: structure has no member named `visual'
> drivers/video/radeonfb.c:1422: structure has no member named `line_length'
> drivers/video/radeonfb.c: In function `radeonfb_get_fix':
> drivers/video/radeonfb.c:1514: structure has no member named `type'
> drivers/video/radeonfb.c:1515: structure has no member named `type_aux'
> drivers/video/radeonfb.c:1516: structure has no member named `visual'
> drivers/video/radeonfb.c:1522: structure has no member named `line_length'
> drivers/video/radeonfb.c: In function `radeonfb_set_var':
> drivers/video/radeonfb.c:1578: structure has no member named `line_length'
> drivers/video/radeonfb.c:1579: structure has no member named `visual'
> drivers/video/radeonfb.c:1590: structure has no member named `line_length'
> drivers/video/radeonfb.c:1591: structure has no member named `visual'
> drivers/video/radeonfb.c:1606: structure has no member named `line_length'
> drivers/video/radeonfb.c:1607: structure has no member named `visual'
> drivers/video/radeonfb.c:1619: structure has no member named `line_length'
> drivers/video/radeonfb.c:1620: structure has no member named `visual'
> drivers/video/radeonfb.c: At top level: drivers/video/radeonfb.c:2487:
> warning: `fbcon_radeon8' defined but not used
> drivers/video/radeonfb.c:598: warning: `radeon_read_OF' declared `static'
> but never defined drivers/video/radeonfb.c:1710: warning:
> `radeonfb_set_cmap' defined but not used

It's currently broken due to major changes in the fbdev API.  However, a 
working version (at least according to its mantainer) can be had by pulling 
from bk://ppc.bkbits.net/linuxppc-2.5.  I'm still working on getting my 
kernel to compile, so I can't speak to how well that driver works.  Still, 
it's better then not compiling at all.

Cheers,
Nicholas



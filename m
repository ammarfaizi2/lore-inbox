Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267502AbTAGVoV>; Tue, 7 Jan 2003 16:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267504AbTAGVoV>; Tue, 7 Jan 2003 16:44:21 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:24580 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267502AbTAGVoV>; Tue, 7 Jan 2003 16:44:21 -0500
Date: Tue, 7 Jan 2003 21:51:52 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
In-Reply-To: <20030104233008.GB1188@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0301072147070.17129-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why? (a) only those which will use putcs, and (b) I see no 512 chars limit
> anywhere in new code. And in old code it is there only because of passed
> data are only 16bit, not 32bit wide... With simple search&replace you can
> extend it to any size you want, as long as you'll not use sparse font
> bitmap.

The current "core" console code screen_buf layout is designed after VGA 
text mode. 16 bits which only 8 bits are used to represent a character, 9 
if you have high_fonts flag set. The other 8,7 bits are for attributes. 
This is very limiting and it does effect fbcon.c :-( I like to the console
system remove these awful limitation in the future. This why I like to see 
fbdev drivers avoid touching strings from the console layer.



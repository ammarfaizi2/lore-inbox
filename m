Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSLMVlh>; Fri, 13 Dec 2002 16:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265477AbSLMVlh>; Fri, 13 Dec 2002 16:41:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23565 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265475AbSLMVlg>; Fri, 13 Dec 2002 16:41:36 -0500
Date: Fri, 13 Dec 2002 13:50:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Simmons <jsimmons@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK fbdev] Yet again more fbdev updates.
In-Reply-To: <Pine.LNX.4.33.0212091651540.2360-100000@maxwell.earthlink.net>
Message-ID: <Pine.LNX.4.44.0212131347240.10159-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James,
 the fbcon update seems to have broken the plain VGA console. I get a page
fault at vgacon_scroll+0x144, the call sequence seems to be:

	vt_console_print+0x203
	set_cursor+0x78
	vgacon_cursor+x0xb5
	scrup+0x122
	vgacon_scroll+0x144

I don't know what triggers it, since it seems to happen pretty randomly.

		Linus


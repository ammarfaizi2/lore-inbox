Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSKRJJK>; Mon, 18 Nov 2002 04:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSKRJJK>; Mon, 18 Nov 2002 04:09:10 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:23460
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261732AbSKRJJK>; Mon, 18 Nov 2002 04:09:10 -0500
Date: Mon, 18 Nov 2002 04:19:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Greg Kroah-Hartmann <greg@kroah.com>
Subject: Re: [PATCH][2.5] USB core/config.c == memory corruption (resend)
In-Reply-To: <Pine.LNX.4.44.0211180202090.1538-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0211180412360.1538-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got larted on the grounds that i write lame changelogs so here we go 
again :}

parse_interface allocates the incorrect storage size for additional 
altsettings (new buffer) leading to a BUG being triggered in 
mm/slab.c:1453 when we do the memcpy from the old buffer to the new 
buffer (writing beyond new buffer).

	Zwane
-- 
function.linuxpower.ca



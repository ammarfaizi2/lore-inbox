Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136701AbREGXFN>; Mon, 7 May 2001 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136704AbREGXFD>; Mon, 7 May 2001 19:05:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45994 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136701AbREGXEs>;
	Mon, 7 May 2001 19:04:48 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.10766.342088.612404@pizda.ninka.net>
Date: Mon, 7 May 2001 16:04:46 -0700 (PDT)
To: Ben LaHaise <bcrl@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero^H^H^H^Hsingle copy pipe
In-Reply-To: <Pine.LNX.4.33.0105071243450.8156-100000@devserv.devel.redhat.com>
In-Reply-To: <001601c0d713$d60a17b0$5517fea9@local>
	<Pine.LNX.4.33.0105071243450.8156-100000@devserv.devel.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben LaHaise writes:
 > and then use a map_mm_kiobuf (which is
 > map_user_kiobuf but with an mm parameter) for the portion of the buffer
 > that's currently being copied.  That improves code reuse and gives us a
 > few primatives that are quite useful elsewhere.

If it has roughly the same cost as Manfred's copy_user thing, it is
therefore roughly equivalent.

If this map_mm_kiobuf() thing would cost more (I think it would
because it would be using kiobufs when for this case there is
absolutely no need for them) then why?  "It's a clean interface
everyone can use" is not an acceptable answer when the clean interface
costs significantly more than the straightforward approach.

Later,
David S. Miller
davem@redhat.com

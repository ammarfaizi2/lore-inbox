Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129274AbRBZXwU>; Mon, 26 Feb 2001 18:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRBZXwL>; Mon, 26 Feb 2001 18:52:11 -0500
Received: from pizda.ninka.net ([216.101.162.242]:31903 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129274AbRBZXwC>;
	Mon, 26 Feb 2001 18:52:02 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15002.60239.486243.682681@pizda.ninka.net>
Date: Mon, 26 Feb 2001 15:48:31 -0800 (PST)
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: New net features for added performance
In-Reply-To: <oupsnl3k5gs.fsf@pigdrop.muc.suse.de>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
	<oupsnl3k5gs.fsf@pigdrop.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > 4) Better support for aligned RX by only copying the header

Andi you can make this now:

1) Add new "post-header data pointer" field in SKB.
2) Change drivers to copy into aligned headroom as
   you mention, and they set this new post-header
   pointer as appropriate.  For normal drivers without
   alignment problem, generic code sets the pointer up
   just like it does the rest of the SKB header pointers
   now.
3) Enforce correct usage of it in all the networking :-)

I would definitely accept such a patch for the 2.5.x
series.  It seems to be a nice idea and I currently see
no holes in it.

Later,
David S. Miller
davem@redhat.com

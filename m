Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRB0AMn>; Mon, 26 Feb 2001 19:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129300AbRB0AMe>; Mon, 26 Feb 2001 19:12:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47263 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129292AbRB0AMW>;
	Mon, 26 Feb 2001 19:12:22 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15002.61448.626860.33433@pizda.ninka.net>
Date: Mon, 26 Feb 2001 16:08:40 -0800 (PST)
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: New net features for added performance
In-Reply-To: <20010227010336.A25816@gruyere.muc.suse.de>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
	<oupsnl3k5gs.fsf@pigdrop.muc.suse.de>
	<15002.60239.486243.682681@pizda.ninka.net>
	<20010227010336.A25816@gruyere.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > Or did I misunderstand you?

What is wrong with making methods, keyed off of the ethernet protocol
ID, that can do the "I know where/how-long headers are" stuff for that
protocol?  Only cards with the problem call into this function vector
or however we arrange it, and then for those that don't have these
problems at all we can make NULL a special value for this
"post-header" pointer.

You can pick some arbitrary number, sure, that is another way to
do it.  Such a size would need to be chosen very carefully though.

Later,
David S. Miller
davem@redhat.com

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTEYV7s (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 17:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTEYV7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 17:59:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1295 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263786AbTEYV7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 17:59:47 -0400
Date: Sun, 25 May 2003 15:12:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
   "David S. Miller" <davem@redhat.com>
Subject: Re: netlink init order
In-Reply-To: <20030525220709.GJ6270@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0305251511140.1741-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 May 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> BTW, is there any reason why init_netlink_dev() is not a module_init()?

Probably not. I don't know if the thing even makes sense without a user 
space, which definitely implies that it shouldn't be a "core" initcall.

Even more true as it seems to depend on other core subsystems already 
being initialized.

Davem? Who uses this thing?

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUE3DZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUE3DZf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 23:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUE3DZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 23:25:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:5042 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261606AbUE3DZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 23:25:34 -0400
Date: Sat, 29 May 2004 20:25:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Jeff Garzik <jgarzik@pobox.com>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] remove net driver ugliness that sparse complains about
In-Reply-To: <20040529204230.GG12308@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0405292022380.1705@ppc970.osdl.org>
References: <40B8D2F8.6090905@pobox.com> <Pine.LNX.4.58.0405291117511.1648@ppc970.osdl.org>
 <20040529204230.GG12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 May 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Right now there is only one serious false positive I know about.
> 	put_user(0, dirent->d_name) and its equivanlents in some places.  
> That's __typeof__() handling bug.

It should be fixed now. It wasn't typeof, it was a general array derefence
type issue ("*array" needs to pick up the attributes of the array and
apply them to the sub-node).

Lots fewer sparse complaints now. Both sparse fixes and the kernel stuff 
pushed out.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUHHFZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUHHFZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 01:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUHHFZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 01:25:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:6876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265148AbUHHFZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 01:25:27 -0400
Date: Sat, 7 Aug 2004 22:25:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Morris <jmorris@redhat.com>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjanv@redhat.com, dwmw2@infradead.org,
       greg@kroah.com, Chris Wright <chrisw@osdl.org>, sfrench@samba.org,
       mike@halcrow.us, Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] implement in-kernel keys & keyring management
In-Reply-To: <Xine.LNX.4.44.0408080046130.27710-100000@dhcp83-76.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0408072221480.1793@ppc970.osdl.org>
References: <Xine.LNX.4.44.0408080046130.27710-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Aug 2004, James Morris wrote:
> 
> I would suggest that the /sbin/request-key interface be done via Netlink
> messaging instead.  The kernel would generate key create and key update
> messages, to which userpace daemons can respond (similar to e.g. pfkey
> acquire).  I think these messages need to be tagged with the key 'type',
> so that the userspace code knows what to generate keys for.

I really disagree. 

If you want to use netlink, do so. But do it from the /sbin/request-key
script or binary.

I've never seen a good binary deamon listening for things. It's a horrible 
interface. It's undebuggable, it's inflexible, and it's just plain nasty. 

I'm just looking at how _well_ /sbin/hotplug has worked out. I believe 
that it would have been a disaster done with a binary messaging setup.

		Linus

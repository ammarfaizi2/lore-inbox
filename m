Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266166AbUHIGcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUHIGcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 02:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUHIGcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 02:32:16 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:55012 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266166AbUHIGcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 02:32:14 -0400
Date: Mon, 9 Aug 2004 08:32:12 +0200
From: bert hubert <ahu@ds9a.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Morris <jmorris@redhat.com>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjanv@redhat.com,
       dwmw2@infradead.org, greg@kroah.com, Chris Wright <chrisw@osdl.org>,
       sfrench@samba.org, mike@halcrow.us,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] implement in-kernel keys & keyring management
Message-ID: <20040809063212.GA16123@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	James Morris <jmorris@redhat.com>,
	David Howells <dhowells@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, arjanv@redhat.com, dwmw2@infradead.org,
	greg@kroah.com, Chris Wright <chrisw@osdl.org>, sfrench@samba.org,
	mike@halcrow.us, Trond Myklebust <trond.myklebust@fys.uio.no>,
	Kyle Moffett <mrmacman_g4@mac.com>
References: <Xine.LNX.4.44.0408082041010.1123-100000@dhcp83-76.boston.redhat.com> <Pine.LNX.4.58.0408082114230.1832@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408082114230.1832@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 09:27:15PM -0700, Linus Torvalds wrote:

> Yes. However, I don't see that the kernel really would ask for new keys 
> very often.  Any normal operation is that you have the key already.

Key might not be there though, leading to many repeated requests. Three
points:

1) A netlink binary "server" looks a hell of a lot like a nameserver, and
those are a roaring success in terms of stability and performance. When
considering nameservers other than bind, I'd also add security and leanness
to that list.

2) One can also send text over datagrams (think SIP)

3) Debugging netlink communications is actually not that hard as other
processes can listen in on netlink communications given certain settings,
think 'netlinkdump'. Especially easy when doing ASCII over netlink!

Bert.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUHIP5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUHIP5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266730AbUHIPyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:54:43 -0400
Received: from the-village.bc.nu ([81.2.110.252]:39881 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266666AbUHIPyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:54:18 -0400
Subject: Re: [PATCH] implement in-kernel keys & keyring management
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Morris <jmorris@redhat.com>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjanv@redhat.com, dwmw2@infradead.org, greg@kroah.com,
       Chris Wright <chrisw@osdl.org>, sfrench@samba.org, mike@halcrow.us,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Kyle Moffett <mrmacman_g4@mac.com>
In-Reply-To: <Pine.LNX.4.58.0408082114230.1832@ppc970.osdl.org>
References: <Xine.LNX.4.44.0408082041010.1123-100000@dhcp83-76.boston.redhat.com>
	 <Pine.LNX.4.58.0408082114230.1832@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092063060.14152.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 15:51:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 05:27, Linus Torvalds wrote:
> But at least to me, the /sbin/request-key thing is more like loading a 
> module. You might do it to mount a filesystem or read an encrypted volume, 
> but you wouldn't do it in the "normal" workload. It's a major event.

The BSD networking PF_KEY does exactly this for IPsec sockets. Coupled
with a cache it seems to work rather well. In fact is there a reason for
not using PF_KEY - other than /sbin/hotplug being cleaner ?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263252AbUDZTMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263252AbUDZTMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 15:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUDZTMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 15:12:50 -0400
Received: from ns.suse.de ([195.135.220.2]:63180 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263252AbUDZTMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 15:12:45 -0400
Subject: Re: I oppose Chris and Jeff's patch to add an
	unnecessary	additional namespace to ReiserFS
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, akpm@osdl.org
In-Reply-To: <408D51C4.7010803@namesys.com>
References: <1082750045.12989.199.camel@watt.suse.com>
	 <408D3FEE.1030603@namesys.com> <1083000711.30344.44.camel@watt.suse.com>
	 <408D51C4.7010803@namesys.com>
Content-Type: text/plain
Message-Id: <1083006783.30344.102.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 15:13:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 14:15, Hans Reiser wrote:
> Chris Mason wrote:
> 
> >On Mon, 2004-04-26 at 12:59, Hans Reiser wrote:
> >
> >v4 didn't factor into these decisions because it was still in extremely
> >early stages back then (2.4.16 or so). 
> >
> It was clearly indicated then that accessing acls was scheduled for V4 
> not V3. 
> 
Well, that part we've always disagreed most on is how to support
existing users.  SUSE implemented the acls for v3 because we felt they
were an important feature, and didn't want to tell users asking for ACLs
to switch filesystems when it was reasonable to implement in v3.

It seems that you don't want the ACLs in v3 for two major reasons:

1) it's not v4
2) it's based on xattrs

I don't feel this is a good way to support v3, since v4 still means
telling someone to switch just for acls, and not using xattrs means not
using the same API as the rest of the kernel.

I hope v4 does improve the xattr api, and I hope it manages to do so for
more then just reiser4.  It is important that application writers are
able to code to a single interface and get coverage across all the major
linux filesystems.

-chris



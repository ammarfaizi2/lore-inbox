Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVD2Tx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVD2Tx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVD2Tx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:53:57 -0400
Received: from pat.uio.no ([129.240.130.16]:16083 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262916AbVD2Txz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:53:55 -0400
Subject: Re: which ioctls matter across filesystems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42728964.8000501@austin.rr.com>
References: <42728964.8000501@austin.rr.com>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 15:53:45 -0400
Message-Id: <1114804426.12692.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.82, required 12,
	autolearn=disabled, AWL 1.18, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 29.04.2005 Klokka 14:22 (-0500) skreiv Steve French:

> The new inotify mechanism being prototyped in -mm currently is the other 
> one which needs work to determine how to map it across the network.   
> Since it was added for support of Samba, the corresponding client part 
> (for cifs) may turn out to map to the network protocol quite well 
> already, and given NFSv4 having various similarities to CIFS, it would 
> be interesting if the semantics of inotify would map to NFSv4 write 
> protocol.

We are discussing the equivalent of dnotify as a potential candidate for
the first minor version of NFSv4, but not inotify.
The purpose of our dnotify implementation is address the needs of things
like file browsers that don't really care about synchronous notification
of changes, but that do currently cause a lot of unnecessary traffic on
the wire due to constantly polling stat() and doing readdir() updates.
The jury is still out as to whether or not the callbacks actually do
reduce on-the-wire traffic, though, so we may drop it.

What kind of real-world applications exist out there that need inotify
functionality, and what sort of requirements do they have (in particular
w.r.t. the notification mechanism)?

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>


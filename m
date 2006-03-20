Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWCTNjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWCTNjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWCTNje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:39:34 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:52714 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964791AbWCTNj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:39:26 -0500
To: arjan@infradead.org
CC: matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1142861441.3114.45.camel@laptopd505.fenrus.org> (message from
	Arjan van de Ven on Mon, 20 Mar 2006 14:30:41 +0100)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
	 <20060320121107.GE8980@parisc-linux.org>
	 <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
	 <20060320123950.GF8980@parisc-linux.org>
	 <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
	 <1142860423.3114.41.camel@laptopd505.fenrus.org>
	 <E1FLKMl-0008Gh-00@dorka.pomaz.szeredi.hu> <1142861441.3114.45.camel@laptopd505.fenrus.org>
Message-Id: <E1FLKbA-0008KR-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Mar 2006 14:39:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> but the point is that with unix sockets you can send inodes to other
> processes.. who don't share files_struct

In which case the other process won't be able to manipulate
(unlock/upgrade/etc) the lock, since it doesn't own the lock (unless
it shares files_struct with the original process).

Miklos

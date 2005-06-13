Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVFMTXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVFMTXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVFMTXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:23:16 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:45532 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261205AbVFMTXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:23:12 -0400
Subject: Re: A Great Idea (tm) about reimplementing NLS.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <f192987705061310202e2d9309@mail.gmail.com>
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <1118669746.13260.20.camel@localhost.localdomain>
	 <f192987705061310202e2d9309@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118690448.13770.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Jun 2005 20:20:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-13 at 18:20, Alexey Zaytsev wrote:
> Yes, that's how it works, but if I want ext or reiser or whatever to
> have NLS, I'll have to make them support it (btw, if I do so, wont it
> be rejected?). I want to move the NLS one level upper so the
> filesystem imlementations won't have to worry about it any more. I
> don't have much kernel experience, and none in the fs area, so I can't
> explain it any better, but hope you get the idea.

An ext3fs is always utf-8. People might have chosen to put other
encodings on it but thats "not our fault" ;)

There are some good technical reasons too

Encodings don't map 1:1 - two names may cease to be unique

Encodings vary in length - image a file name that is longer than the
allowed maximum on your system with your encoding choice - that could
occur with KOI8-R to UTF-8 I believe

That said it ought to be possible to use the stackable fs work (FUSE
etc) to write a layer you can mount over any fs that does NLS
translation.


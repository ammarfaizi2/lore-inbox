Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317020AbSGURsx>; Sun, 21 Jul 2002 13:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSGURsx>; Sun, 21 Jul 2002 13:48:53 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:37344 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S317020AbSGURsx>; Sun, 21 Jul 2002 13:48:53 -0400
Date: Sun, 21 Jul 2002 10:51:59 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
In-Reply-To: <Pine.LNX.4.44.0207210934180.3794-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207211034100.29405-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002, Linus Torvalds wrote:

> The fact is, the linuxism exists, and breaking it is worse than not
> breaking it.

fortunately, glibc uses poll() rather than select() these days (so that it
avoids bugs with programs with huge numbers of fds).  so that ancient code
in the libc5 resolver (see res_send) which still relies on this linuxism
is dying out :)

-dean


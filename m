Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262009AbRETAHC>; Sat, 19 May 2001 20:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262012AbRETAGw>; Sat, 19 May 2001 20:06:52 -0400
Received: from pop.gmx.net ([194.221.183.20]:15018 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262009AbRETAGo>;
	Sat, 19 May 2001 20:06:44 -0400
Message-ID: <3B07074B.A6964617@gmx.de>
Date: Sun, 20 May 2001 01:52:43 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.GSO.4.21.0105190940310.5339-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nitpicking: a system call without side effects would be pretty useless.

Alexander Viro wrote:
> A lot of stuff relies on the fact that close(open(foo, O_RDONLY)) is a
> no-op. Breaking that assumption is a Bad Thing(tm).

That assumption is totally bogus.  Even for regular files you have side
effects (atime); for anything else they're unpredictable.

Ciao, ET.

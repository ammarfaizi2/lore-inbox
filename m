Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318955AbSICW2o>; Tue, 3 Sep 2002 18:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318959AbSICW2o>; Tue, 3 Sep 2002 18:28:44 -0400
Received: from kim.it.uu.se ([130.238.12.178]:62888 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S318955AbSICW2o>;
	Tue, 3 Sep 2002 18:28:44 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15733.14504.976399.246704@kim.it.uu.se>
Date: Wed, 4 Sep 2002 00:33:12 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <Pine.LNX.4.33.0209031450240.10694-100000@penguin.transmeta.com>
References: <15733.8764.96293.719729@harpo.it.uu.se>
	<Pine.LNX.4.33.0209031450240.10694-100000@penguin.transmeta.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > On Tue, 3 Sep 2002, Mikael Pettersson wrote:
 > > 
 > > Confirmed. 2.5.33 + your two patches still corrupts data on a simple
 > > dd to then from /dev/fd0 test.
 > 
 > Ok, if you don't have BK, then here's the floppy driver end_request() 
 > cleanup as a plain patch.
 > 
 > This passes dd tests for me, but they were by no means very exhaustive.

Success! With this patch and your previous two the floppy driver
passes all tests I've thrown at it, including raw data access,
VFS access with ext2, installing lilo, fsck, and booting the result.

Thanks.

/Mikael

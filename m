Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSKCMZy>; Sun, 3 Nov 2002 07:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbSKCMZy>; Sun, 3 Nov 2002 07:25:54 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:30604 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261842AbSKCMZw>; Sun, 3 Nov 2002 07:25:52 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Oliver Xymoron <oxymoron@waste.org>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <Pine.GSO.4.21.0211030138420.25010-100000@steklov.math.psu.edu>
References: <Pine.GSO.4.21.0211030138420.25010-100000@steklov.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 12:53:26 +0000
Message-Id: <1036328006.29711.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 06:46, Alexander Viro wrote:
> Quite so.  Now, ability to _remove_ capabilities on exec() is a Good Thing(tm)
> regardless of suid.  It can be combined with suid - that gives you something
> that is still evil, but less than it used to be.  But I don't see any point
> in new independent mechanism for raising caps - e.g. since it assumes a
> bunch of new programs that were written to run with elevated caps and
> with assumption that they will be less dangerous than suid-root ones.
> Somehow, it doesn't make me happy about running such programs - not for
> first 5 years or so.

Removing capabilities is an easy thing to add. Firstly the binary can do
it anyway even on 2.4, secondly you can add an ELF property easily
enough which says which capabilities this gets if it is marked setuid


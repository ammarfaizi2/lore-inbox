Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbSKCMaM>; Sun, 3 Nov 2002 07:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbSKCMaM>; Sun, 3 Nov 2002 07:30:12 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:33164 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261837AbSKCMaL>; Sun, 3 Nov 2002 07:30:11 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <Pine.LNX.4.44.0211021925230.2382-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211021925230.2382-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 12:57:43 +0000
Message-Id: <1036328263.29642.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 03:35, Linus Torvalds wrote:
> With a simple extended binfmt_misc.c or binfmt_script.c, we could do a
> capability escape (that only removes capabilities, but allows for suid
> shells) fairly easily if people really want it. And it would work on any
> almost-UNIXy filesystem, including NFS etc.
> 
> But I like Al's idea of mount binds even more, although it requires maybe
> a bit more administration.

The two are seperate things IMHO

Namespaces is a way to inherit revocation of rights on a large scale (or
a small one true). #! is a way to handle program specific revocation of
rights which _is_ filesystem persistent.

The former is a database view, the latter is an actual database change


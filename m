Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbRF0AvH>; Tue, 26 Jun 2001 20:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbRF0Au5>; Tue, 26 Jun 2001 20:50:57 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:65293 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S265174AbRF0Aus>;
	Tue, 26 Jun 2001 20:50:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] User chroot
Date: 27 Jun 2001 00:48:14 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9hbage$djn$1@abraham.cs.berkeley.edu>
In-Reply-To: <20010627014534.B2654@ondska> <9hb6rq$49j$1@cesium.transmeta.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 993602894 13943 128.32.45.153 (27 Jun 2001 00:48:14 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 27 Jun 2001 00:48:14 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
>By author:    Jorgen Cederlof <jc@lysator.liu.se>
>> If we only allow user chroots for processes that have never been
>> chrooted before, and if the suid/sgid bits won't have any effect under
>> the new root, it should be perfectly safe to allow any user to chroot.
>
>Safe, perhaps, but also completely useless: there is no way the user
>can set up a functional environment inside the chroot.

Why is it useless?  It sounds useful to me, on first glance.  If I want
to run a user-level network daemon I don't trust (for instance, fingerd),
isolating it in a chroot area sounds pretty nice: If there is a buffer
overrun in the daemon, you can get some protection [*] against the rest
of your system being trashed.  Am I missing something obvious?

[*] Yes, I know chroot is not sufficient on its own to completely
    protect against this, but it is a useful part of the puzzle, and
    there are other things we can do to deal with the remaining holes.

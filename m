Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263934AbTIIEjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 00:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263935AbTIIEjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 00:39:16 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:22730
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263934AbTIIEjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 00:39:15 -0400
Message-ID: <3F5D5946.1030002@redhat.com>
Date: Mon, 08 Sep 2003 21:38:30 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030904 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jeremy@goop.org, mingo@redhat.com, roland@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use group_leader->pgrp (was Re: setpgid and threads)
References: <1061424262.24785.29.camel@localhost.localdomain>	<20030820194940.6b949d9d.akpm@osdl.org>	<1063072786.4004.11.camel@localhost.localdomain>	<20030908191215.22f501a2.akpm@osdl.org>	<1063073637.4004.14.camel@localhost.localdomain>	<20030908202147.3cba2ecd.akpm@osdl.org>	<3F5D4EFA.30102@redhat.com> <20030908211746.25fff0f1.akpm@osdl.org>
In-Reply-To: <20030908211746.25fff0f1.akpm@osdl.org>
X-Enigmail-Version: 0.81.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:

> OK.  There were a few missing ones.  Here's what I have, against test5.  Do
> you have a test suite which would give us reasonable confidence?

Nope, I don't.

Why not leave the element renamed for a test release or two.  So the
nice people who do compile checks on all the drivers will find the
missing changes.


> Should setpgrp() in a thread affect the group leader?   It does...

Yes.  This the existence of a thread group leader different from current
 means using the POSIX thread "process" semantics this is the case.  All
the thread together have only one "process group" ("process" again in
the POSIX sense).

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/XVlG2ijCOnn/RHQRAnZnAJ0SaF7LUcbY/8XKxBnwYzW5pmpeYACglnWh
55qtBiGdqNyl6sAwR6OCPXg=
=5oJh
-----END PGP SIGNATURE-----


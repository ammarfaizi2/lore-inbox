Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265579AbSKFEnw>; Tue, 5 Nov 2002 23:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265578AbSKFEnv>; Tue, 5 Nov 2002 23:43:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12867 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265579AbSKFEnt>; Tue, 5 Nov 2002 23:43:49 -0500
To: Alexander Viro <viro@math.psu.edu>
CC: Werner Almesberger <wa@almesberger.net>, Andy Pfiffer <andyp@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.GSO.4.21.0211052017320.6521-100000@steklov.math.psu.edu>
	<m1heevfiih.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Nov 2002 21:47:58 -0700
In-Reply-To: <m1heevfiih.fsf@frodo.biederman.org>
Message-ID: <m18z07fgn5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And the question I was building up to, but forgot to ask.

Given that the kexec code is tied intimately to the kernel
implementation.

Given that there is no real advantage in an incremental write
model for kexec users (except not needing to allocate a syscall
number).

Do you see a better way to structure the kexec interface?

Another file in proc, not carefully placed is just a hair better than
an ioctl.  Using /proc is not desirable because there are uses of
kexec that need a very small kernel, and /proc is a pig, is otherwise
useless size bloat. 

For some uses including the one that drove me to write it CONFIG_KEXEC
and CONFIG_TINY will both be defined.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUGZCVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUGZCVE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 22:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUGZCVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 22:21:04 -0400
Received: from lakermmtao01.cox.net ([68.230.240.38]:4569 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S264833AbUGZCUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 22:20:51 -0400
Mime-Version: 1.0 (Apple Message framework v618)
Content-Transfer-Encoding: 7bit
Message-Id: <65EFF013-DEAA-11D8-9612-000393ACC76E@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: lkml List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Preliminary Linux Key Infrastructure 0.01-alpha1
Date: Sun, 25 Jul 2004 22:20:44 -0400
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Preliminary Linux Key Infrastructure 0.01-alpha1:

I'm writing a key/keyring infrastructure for the Linux kernel. I've got 
some of the
basic infrastructure done, and I'd like any comments on it that you may 
have.

Please note that as yet none of this has been even compile tested, it 
has
errors galore, and is still very incomplete.  I have only worked on the 
in-kernel
parts of the infrastructure, user-space interfaces and keyctl are on my 
TODO
list. :-D

See below for my current status:

That said, here's a link:
http://www.tjhsst.edu/~kmoffett/lki.tar.bz2

Completed:
	lki_key_t & methods
		A simple key, with a description and a BLOB
	lki_keytype_t & methods
		A module-registered key type description including callbacks
	lki_key_hash_{add,remove,search}
		Lookup up keys by number

In Progress:
	lki_keyring_blob_t & methods
		A special-case of a key. Just needs add and remove key methods
	permissions model
		On hold while I learn more about POSIX ACLs and stuff
	lki_key_handle_t
		This is my next task, it is barely started

TODO:
	keyctl:
		The syscall that makes it all possible
	keyfs:
		keys by number: On hold while I learn more about filesystems :-D
	libinuxkeys:
		A user-space library linked using "gcc -linuxkeys" :-D

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


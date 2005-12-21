Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVLULVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVLULVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVLULVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:21:46 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:33014 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S932366AbVLULVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:21:46 -0500
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: [RFC] TOMOYO Linux released!
From: Tetsuo Handa <from-kernelnewbies@I-love.SAKURA.ne.jp>
Message-Id: <200512212020.FBF94703.XOTMFStFPCJNSFLFOG@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Wed, 21 Dec 2005 20:21:24 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

A new and easy to master access control for Linux,
TOMOYO Linux, is now available.

TOMOYO Linux is a small kernel patch that provides
MAC (Mandatory Access Control) functions to Linux.

TOMOYO Linux was developed by NTT DATA CORPORATION, Japan,
and released under GPL license.

TOMOYO Linux has the following features.
Please see documentations and papers for details.
(There are 5 papers written in Japanese.
 2 of them are available in English, as shown below.
 Translation of 3 papers is now in progress.)

(1) Takes full advantage of "struct task_struct".

(2) Uses realpath(2), the kernel version of realpath(3).

(3) Works for 2.4.30/2.6.11 and later.

TOMOYO Linux includes the following components.

(1) Domain-Free Mandatory Access Control
    (Code name is SAKURA, which is the acronym for
     "Security Advancement Know-how Upon Readonly Approach".)

(2) Domain-Based Mandatory Access Control
    (Code name is TOMOYO, which is the acronym for
     "Task Oriented Management Obviates Your Onus".)
    http://sourceforge.jp/projects/tomoyo/document/lc2005-en.pdf

(3) Tamper-Proof Device Filesystem
    (Code name is SYAORAN, which is the acronym for
     "Simple Yet All-important Object Realizing Abiding Nexus".)

(4) Never breakable Login Authentication
    (Code name is CERBERUS, which is the acronym for
     "Chained Enforceable Re-authentication Barrier Ensures Really Unbreakable Security".)
    http://sourceforge.jp/projects/tomoyo/document/winf2005-en.pdf

(5) Delegation of Administration Tasks
    (Code name is YUE, which is the acronym for
     "Your User-role Enforcer".)

TOMOYO Linux has 3 usages.

(1) Provide MAC to improve security dramatically for servers.

    TOMOYO Linux provides realpath(2)-based MAC
    with automatic policy generation technology.
    You can generate policies from the scratch
    by just operating what you want to allow.
    TOMOYO Linux will generate policy that only allows
    what you have operated.

(2) Analysis system behavior.

    You can use TOMOYO Linux for examination purpose.

    You can know which application accesses
    to which files and directories.

    To define policies for MAC, you need to know
    which application accesses to which files and directories.
    TOMOYO Linux reports you with realpath(2)-based pathnames
    to help your policy definition.
    I think this is helpful for developing SELinux's policy.

(3) Create filesystem images with minimum files.

    You can use TOMOYO Linux to create the custom
    filesystem image with the minimum files.
    TOMOYO produces realpath(2)-based policy file,
    and you can create filesystem image
    by just copying files listed in the policy file.
    This is useful for creating custom initrd.img .

Project URL:  http://tomoyo.sourceforge.jp/
Download URL: http://sourceforge.jp/projects/tomoyo/

The authors of this patch (hereafter, we) don't have much experience
in kernel programming. But we could accomplish primarily
due to your unstinting support. Thank you very much.

We are worried that this patch would contain some mistakes
such as missing hooks, improper location of hooks, potential deadlocks.
There would be better way of implementation.
All kinds of comments, pointing the errors and suggestions are welcome.

We do hope this patch reduces the labor of server security management
and you enjoy the life with Linux.

Happy Holidays!

Thank you.

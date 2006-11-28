Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758657AbWK1NFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758657AbWK1NFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 08:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758655AbWK1NFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 08:05:00 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:22159 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1758654AbWK1NE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 08:04:59 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Entropy Pool Contents
Date: Tue, 28 Nov 2006 12:58:05 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ekhbot$ofm$1@taverner.cs.berkeley.edu>
References: <ek2nva$vgk$1@sea.gmane.org> <ekgd7u$6gp$1@taverner.cs.berkeley.edu> <878xhw5esn.fsf@blp.benpfaff.org> <20061128121346.GB8499@khazad-dum.debian.net>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1164718685 25078 128.32.168.222 (28 Nov 2006 12:58:05 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Tue, 28 Nov 2006 12:58:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Continuing the tangent:

Henrique de Moraes Holschuh  wrote:
>On Mon, 27 Nov 2006, Ben Pfaff wrote:
>> daw@cs.berkeley.edu (David Wagner) writes:
>> > Well, if you want to talk about really high-value keys like the scenarios
>> > you mention, you probably shouldn't be using /dev/random, either; you
>> > should be using a hardware security module with a built-in FIPS certified
>> > hardware random number source.  
>> 
>> Is there such a thing?  [...]
>
>There used to exist a battery of tests for this, but a FIPS revision removed
>them. [...]

The point I was making in my email was not about the use of FIPS
randomness tests.  The FIPS randomness tests are not very important.
The point I was making was about the use of a hardware security module
to store really high-value keys.  If you have a really high-value key,
that key should never be stored on a Linux server: standard advice is
that it should be generated on a hardware security module (HSM) and never
leave the HSM.  If you are in charge of Verisign's root cert private key,
you should never let this private key escape onto any general-purpose
computer (including any Linux machine).  The reason for this advice is
that it's probably much harder to hack a HSM remotely than to hack a
general-purpose computer (such as a Linux machine).

Again, this is probably a tangent from anything related to Linux kernel
development.

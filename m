Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266413AbTGERCJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 13:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266414AbTGERCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 13:02:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1951 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266413AbTGERCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 13:02:07 -0400
Date: Sat, 5 Jul 2003 10:16:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>, <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
In-Reply-To: <20030705104428.GA19311@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0307051013140.5900-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jul 2003, Jörn Engel wrote:
> 
> Except that the patch didn't match the description.  My test loops
> just as happily as before and the conditional part of give_sigsegv is
> pointless now.  That might really break some threading stuff.

Hmm? I tried it, and for me it does:

	torvalds@home:~> ./a.out 
	SIGNAL .... 11
	Segmentation fault

but I have to admit that I didn't even try it before my kernel change, so 
maybe it worked for me before too ;)

There could easily be glibc version issues here, ie maybe your library 
sets SA_NOMASK and mine doesn't.

		Linus


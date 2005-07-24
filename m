Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVGXTro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVGXTro (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVGXTrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 15:47:43 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:703 "HELO
	dag.newtech.fi") by vger.kernel.org with SMTP id S261182AbVGXTri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 15:47:38 -0400
Message-ID: <20050724194737.30199.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: Ciprian <cipicip@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dag@newtech.fi
Subject: Re: kernel 2.6 speed 
In-Reply-To: Message from Ciprian <cipicip@yahoo.com> 
   of "Sun, 24 Jul 2005 12:12:11 PDT." <20050724191211.48495.qmail@web53608.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Jul 2005 22:47:37 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In windows were performed about 300 millions cycles,
> while in Linux about 10 millions. This test was run on
> Fedora 4 and Suse 9.2 as Linux machines, and Windows
> XP Pro with VS .Net 2003 on the MS side. My CPU is a
> P4 @3GHz HT 800MHz bus.
> 
> I published my little test on several forums and I
> wasn't the only one who got these results. All the
> other users using 2.6 kernel obtained similar results
> regardless of the CPU they had (Intel or AMD). 

Looking at the gcc-produced code from youe test program I 
can see the floating point math beeing optimized away all
together as you are not using the result and the rest more
or less boils down to the call to time() and a few moves
and compares of the time values.
In other words it seems like you are testing the efficiency of
the time() function...

BRGDS
Dag


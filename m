Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWGRE1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWGRE1z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 00:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWGRE1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 00:27:55 -0400
Received: from intrepid.intrepid.com ([192.195.190.1]:41688 "EHLO
	intrepid.intrepid.com") by vger.kernel.org with ESMTP
	id S1750729AbWGRE1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 00:27:54 -0400
From: "Gary Funck" <gary@intrepid.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Vishal Patil" <vishpat@gmail.com>
Subject: RE: Generic B-tree implementation
Date: Mon, 17 Jul 2006 21:27:55 -0700
Message-ID: <JCEPIPKHCJGDMPOHDOIGIELCDFAA.gary@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
In-Reply-To: <4745278c0607171902pc218a9dn9c63dd6670ac7249@mail.gmail.com>
X-Spam-Score: -1.44 () ALL_TRUSTED
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Vishal Patil wrote:
> 
> I am attaching source files containing a very generic implementation
> of B-trees in C. The implementation corresponds to in memory B-Tree
> data structure. The B-tree library consists of two files, btree.h and
> btree.c. I am also attaching a sample program main.c which should
> hopefully make the use of the library clear.

Couple of thoughts:

1. red/black b-trees have superior worst case performance as it
relates to rebalancing, and the implementation doesn't add a
lot of complexity:
http://www.nist.gov/dads/HTML/redblack.html

2. Paul Vixie's b-tree implementation has been around since the mid-80's
or so, and simply from an historical perspective is worth a look
(comp.sources.unix anyone?):
http://www.isc.org/index.pl?/sources/devel/func/avl-subs-2.php

3. GCC uses 'splay trees' to good advantage:
http://www.nist.gov/dads/HTML/splaytree.html
which have the property that most-recently referenced nodes
tend to be higher up in the tree.


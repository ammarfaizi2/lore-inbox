Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWGRPAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWGRPAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWGRPAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:00:21 -0400
Received: from intrepid.intrepid.com ([192.195.190.1]:152 "EHLO
	intrepid.intrepid.com") by vger.kernel.org with ESMTP
	id S932257AbWGRPAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:00:20 -0400
From: "Gary Funck" <gary@intrepid.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Vishal Patil" <vishpat@gmail.com>
Subject: RE: Generic B-tree implementation
Date: Tue, 18 Jul 2006 08:00:25 -0700
Message-ID: <JCEPIPKHCJGDMPOHDOIGCELEDFAA.gary@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
In-Reply-To: <4745278c0607180630m39040ad7neac25c1a64399aff@mail.gmail.com>
X-Spam-Score: -1.44 () ALL_TRUSTED
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Vishal Patil wrote:
> I said B-Tree and not binary tree, please read the explaination about
> B-tree at http://en.wikipedia.org/wiki/B-tree. Also I am aware of AVL
> trees.
> 
> I never claimed that my implementation is better or anything like
> that. I posted the code so that someone in need of the data structure
> might use it. Also I would be willing them to help with their project.

My reason for pointing out the other data strucutres is to note that there
might be search tree representations that are more appropriate for
implementation inside the kernel, and to perhaps encourage you to have
a look at implementing them as well.  Red-black trees in particular have
the property that they're reasonably well-balanced, and that the balancing
algorithm makes use of local information.  That means that the kernel might
be able to limit the level of locking required to update the tree.

I liked your B-tree implementation, and have saved a copy.  Too bad there
isn't the C/C++ equivalent of CPAN (comp.unix.sources is so passe`).  Your
B-tree implementation would make a nice addition to an archive of
handy C algorithm implementations.

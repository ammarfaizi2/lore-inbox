Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVITS0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVITS0y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVITS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:26:54 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:4238 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S965032AbVITS0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:26:53 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17200.21620.684685.966054@gargle.gargle.HOWL>
Date: Tue, 20 Sep 2005 22:27:00 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Newsgroups: gmane.linux.kernel,gmane.comp.file-systems.reiserfs.general
In-Reply-To: <43304AF2.8080404@namesys.com>
References: <200509201542.j8KFgh2q011730@laptop11.inf.utfsm.cl>
	<43304AF2.8080404@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
 > Horst von Brand wrote:
 > 
 > >
 > >
 > >Funny that the "texbook algorithms" aren't used in real life. Wonder why...
 > >  
 > >
 > Try BSD.  If the BSD book can be believed, they use"texbook algorithms".

The "textbook" one-way elevator (as indeed exemplified by FreeBSD's
src/sys/kern/subr_disk.c:bioq_disksort()) has well-known weaknesses. For
example,

    dd if=/dev/zero of=FILE

can easily monopolize device queue and starve accesses to the blocks
with low block numbers.

 > 
 > ;-)

Nikita.

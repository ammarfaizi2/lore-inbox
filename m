Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269718AbUHZWZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269718AbUHZWZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUHZWZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:25:13 -0400
Received: from [213.85.13.118] ([213.85.13.118]:39041 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S269761AbUHZWWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:22:00 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16686.25191.635556.817958@gargle.gargle.HOWL>
Date: Fri, 27 Aug 2004 02:21:27 +0400
To: Christophe Saout <christophe@saout.de>
Cc: Jamie Lokier <jamie@shareable.org>,
       Jonathan Abbey <jonabbey@arlut.utexas.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <1093556917.13881.78.camel@leto.cs.pocnet.net>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
	<200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040826193617.GA21248@arlut.utexas.edu>
	<20040826201639.GA5733@mail.shareable.org>
	<1093551956.13881.34.camel@leto.cs.pocnet.net>
	<16686.23053.559951.815883@thebsh.namesys.com>
	<1093556917.13881.78.camel@leto.cs.pocnet.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout writes:
 > Am Freitag, den 27.08.2004, 01:45 +0400 schrieb Nikita Danilov:
 > 
 > >  > At least in reiser4 they don't have, or at least you can't access them.
 > > 
 > > They do.
 > > 
 > >  > ln -s foo bar; cd bar/metas shows me the content of foo/metas.
 > > 
 > > That's because lookup for "bar" performs symlink resolution.
 > 
 > So I can't access them and it is pointless. ;-)
 > 
 > BTW, I can do a cd metas/metas/metas/metas/plugin/metas... I don't think
 > this makes sense. :)

Why? foo/metas is a file system object just like foo. It has owner,
permission bits, so access to its meta-data should be provided, and
uniform way to provide access to the file system object meta-data is to
have these little magic files inside metas directory, which is a file
system object just like metas. It has owner^@^@^@^@*** - Lisp stack
overflow. RESET

Nikita.

 > 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269735AbUHZVt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269735AbUHZVt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269742AbUHZVrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:47:17 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:10639 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S269735AbUHZVpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:45:53 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16686.23053.559951.815883@thebsh.namesys.com>
Date: Fri, 27 Aug 2004 01:45:49 +0400
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
In-Reply-To: <1093551956.13881.34.camel@leto.cs.pocnet.net>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
	<200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040826193617.GA21248@arlut.utexas.edu>
	<20040826201639.GA5733@mail.shareable.org>
	<1093551956.13881.34.camel@leto.cs.pocnet.net>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout writes:
 > Am Donnerstag, den 26.08.2004, 21:16 +0100 schrieb Jamie Lokier:
 > 
 > > > | Will it work out if "dir inside file" will only be visible when
 > > > referred as "file/."?
 > > > 
 > > > I'm used to using ls symlink/. to get ls to show me the directory on
 > > > the far side of a symbolic link.  That's a pretty analagous case to
 > > > the one we're discussing here, I think?
 > > 
 > > By the way, do symlinks have metadata?  Where do you find it? :)
 > 
 > Oops. :)
 > 
 > At least in reiser4 they don't have, or at least you can't access them.

They do.

 > ln -s foo bar; cd bar/metas shows me the content of foo/metas.

That's because lookup for "bar" performs symlink resolution.
 
 > 
 > symlinks are special anyway. Their rights are 777. The only thing they

Symlink is represented by normal inode in UNIX. It has full set of
attributes. It can even be hard-linked.

 > can have is an owner. No chance to do a symlink/metas/uid then. Hmm.
 > 

Nikita.

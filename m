Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUH2PDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUH2PDN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUH2PDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:03:13 -0400
Received: from alias.nmd.msu.ru ([193.232.127.67]:32291 "EHLO alias.nmd.msu.ru")
	by vger.kernel.org with ESMTP id S268021AbUH2PCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:02:37 -0400
Date: Sun, 29 Aug 2004 19:02:31 +0400
From: Alexander Lyamin <flx@msu.ru>
To: Paul Jackson <pj@sgi.com>
Cc: Hans Reiser <reiser@namesys.com>, riel@redhat.com, ninja@slaphack.com,
       torvalds@osdl.org, diegocg@teleline.es, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re:  silent semantic changes with reiser4
Message-ID: <20040829150231.GE9471@alias>
Reply-To: flx@msu.ru
Mail-Followup-To: flx@msu.ru, Paul Jackson <pj@sgi.com>,
	Hans Reiser <reiser@namesys.com>, riel@redhat.com,
	ninja@slaphack.com, torvalds@osdl.org, diegocg@teleline.es,
	jamie@shareable.org, christophe@saout.de,
	vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
	spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
	hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com,
	reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com> <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827230857.69340aec.pj@sgi.com>
X-Operating-System: Linux 2.6.5-7.104-smp
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Aug 27, 2004 at 11:08:57PM -0700, Paul Jackson wrote:
> Hans wrote:
> > We create filename/pseudos/backup, and that tells the archiver what to 
> > do.....
> 
> Instead of exposing the old semantics under a new interface, why not
> expose the new semantics under a new interface.

yeah. that could work.

> There exist plenty of programs that know the old Unix semantics.  There
> don't exist many working programs that use the new semantics that you're
> adding.
> 
> I raise again the example of how Windows adapted to long filenames.  Old
> DOS and FAT programs, including my Unix backups of today, see a 8.3 name
> space.  Only code that knows the new magic sees the long names.
> 
> If given the choice of breaking much old, existing stuff, or some new,
> mostly not yet existing stuff, does not it make more sense to break what
> mostly doesn't exist yet?
> 
> One possible way to do this, of no doubt many:
> 
>  * Stealing a corner of the existing filename space for
>    some magic names with the new semantics.
> 
>  * A new option on open(2), hence opendir(3), that lights up
>    these magic names.
> 
>  * Doing any of the classic pathname calls with such a
>    new magic name exposes the new semantics - such calls
>    as:
> 	access execve mkdir mknod mount readlink
> 	rename rmdir stat truncate unlink
> 
> This means essentially constructing a map between old and new,
> such that changes made in either view are sane and visible
> from the other view.

It would be intresting to hear comments from Hans Reiser on proposals stated  above...


-- 
"the liberation loophole will make it clear.."
lex lyamin

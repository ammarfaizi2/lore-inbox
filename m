Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264513AbUFNWJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbUFNWJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 18:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUFNWJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 18:09:50 -0400
Received: from pdbn-d9bb9e93.pool.mediaWays.net ([217.187.158.147]:9733 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S264513AbUFNWJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 18:09:46 -0400
Date: Tue, 15 Jun 2004 00:09:17 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Cesar Eduardo Barros <cesarb@nitnet.com.br>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040614220917.GA18941@citd.de>
References: <20040612011129.GD1967@flower.home.cesarb.net> <orpt81sv1g.fsf@free.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orpt81sv1g.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 06:12:59PM -0300, Alexandre Oliva wrote:
> On Jun 11, 2004, Cesar Eduardo Barros <cesarb@nitnet.com.br> wrote:
> 
> > int O_NOATIME  	Macro
> >   If this bit is set, read will not update the access time of the file.
> >   See File Times. This is used by programs that do backups, so that
> >   backing a file up does not count as reading it. Only the owner of the
> >   file or the superuser may use this bit.
> 
> IMHO it's a bad idea to enable the owner of the file to avoid changing
> the atime of their files.  I've heard more than once about the atime
> bit being used to as proof that a user had actually seen the contents
> of a file although s/he claimed s/he hadn't.  If it was root-only,
> atime could still be used for the same purpose, and would enable
> backups with tools that accessed the filesystem through the FS layer,
> as opposed to though the block layer, to keep such proof unchanged.

man mount
/noatime
-> You can disable updating the atime for the whole filesystem.

man utimes/touch -a
-> You can modify "at will" the atime & mtime of a file.


Or in other words, nothing you can't already manipulate at will today.



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.


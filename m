Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbRBYOAk>; Sun, 25 Feb 2001 09:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129225AbRBYOAa>; Sun, 25 Feb 2001 09:00:30 -0500
Received: from mons.uio.no ([129.240.130.14]:4326 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S129216AbRBYOAT>;
	Sun, 25 Feb 2001 09:00:19 -0500
To: David Fries <dfries@umr.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stale NFS handles on 2.4.2
In-Reply-To: <20010214002750.B11906@unthought.net>
	<20010224141855.B12988@d-131-151-189-65.dynamic.umr.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 25 Feb 2001 15:00:11 +0100
In-Reply-To: David Fries's message of "Sat, 24 Feb 2001 14:18:55 -0600"
Message-ID: <shsvgpyual0.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Fries <dfries@umr.edu> writes:

     > I'ved tried `mount /home -o remount`, and reading lots of other
     > directories to flush out that entry if it was in cache without
     > any results.

     > I was hopping to avoid unmounting, as I would have to shut
     > about everything down to do that.

It looks as if you'll have to do that. 'mount -oremount' does not
really cause the root filehandle to get updated. The only thing it
does at the moment is allow you to change from a read-only to a
read-write filesystem.

What kind of filesystem is this BTW: is it an ext2 partition you are
exporting?

Cheers,
  Trond

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265561AbRFVW6y>; Fri, 22 Jun 2001 18:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265563AbRFVW6n>; Fri, 22 Jun 2001 18:58:43 -0400
Received: from mons.uio.no ([129.240.130.14]:52209 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S265562AbRFVW6g>;
	Fri, 22 Jun 2001 18:58:36 -0400
To: Christian Robottom Reis <kiko@async.com.br>
Cc: <NFS@lists.sourceforge.net>, <reiserfs-list@namesys.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] NFS Insanity, v2
In-Reply-To: <Pine.LNX.4.32.0106221643210.183-100000@blackjesus.async.com.br>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 Jun 2001 00:58:15 +0200
In-Reply-To: Christian Robottom Reis's message of "Fri, 22 Jun 2001 16:52:09 -0300 (BRT)"
Message-ID: <shs66do3ywo.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Robottom Reis <kiko@async.com.br> writes:

     > Every day at the same time I pull mozilla-latest through http,
     > and untar it into a directory that is served by nfs. The file
     > isn't too big - around 9MB. It creates a set of files inside
     > /mondo/local/mozilla. One of the files (same one for some
     > reason), components/libgkcontent.so, always ends up corrupted
     > on the client side. There is no server-side corruption.

     > Remounting (and thus rebooting) the client mount gets things
     > back to normal. Anyone willing to track this down with me? Or
     > is it something known (and being worked on, hopefully)?

Is libgkcontents.so in use on the client? If so it's a known problem:
mmap() screws up the page cache invalidation routine
invalidate_inode_page(). If you do the untar on the client, then all
will be fine...

However the last time your report was of a problem in which the server
was corrupted, and the client was good. Was that a typo, or is it
still the case?

Cheers,
  Trond

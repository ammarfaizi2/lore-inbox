Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVFMSfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVFMSfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFMSfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:35:15 -0400
Received: from mail.dif.dk ([193.138.115.101]:20963 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261168AbVFMSfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:35:02 -0400
Date: Mon, 13 Jun 2005 20:40:20 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Dave Jones <davej@redhat.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: update sparse.txt to list actual location
In-Reply-To: <20050613164513.GA19239@redhat.com>
Message-ID: <Pine.LNX.4.62.0506132037290.2555@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506122346250.16521@dragon.hyggekrogen.localhost>
 <20050613054853.GA4753@redhat.com> <9a8748490506130037efae4b@mail.gmail.com>
 <20050613164513.GA19239@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2005, Dave Jones wrote:

> On Mon, Jun 13, 2005 at 09:37:37AM +0200, Jesper Juhl wrote:
>  > On 6/13/05, Dave Jones <davej@redhat.com> wrote:
>  > > On Sun, Jun 12, 2005 at 11:49:30PM +0200, Jesper Juhl wrote:
>  > > 
>  > >  > -and DaveJ has tar-balls at
>  > >  > +like this:
>  > >  >
>  > >  > -    http://www.codemonkey.org.uk/projects/bitkeeper/sparse/
>  > > 
>  > > + http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
>  > > 
>  > Ahh, great, I'll update the patch later today.  Thanks.
> 
> I'm about to jump on a plane, and be net.dead for the
> best part of the next week, with sporadic internet access,
> which is obviously the best time to start cron running
> a hastily hacked up script.
> 
> If it blows up horribly, I'll get to it when I get back on Sunday,
> but it should be fine..  I hope :-)
> 
Have a nice trip.  I've updated the patch to include the new location of 
your tarballs.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 Documentation/sparse.txt |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc6-mm1-orig/Documentation/sparse.txt	2005-03-02 08:37:53.000000000 +0100
+++ linux-2.6.12-rc6-mm1/Documentation/sparse.txt	2005-06-13 20:30:09.000000000 +0200
@@ -51,13 +51,26 @@
 Where to get sparse
 ~~~~~~~~~~~~~~~~~~~
 
-With BK, you can just get it from
+With git, you can get it from
 
-        bk://sparse.bkbits.net/sparse
+	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git/
 
-and DaveJ has tar-balls at
+like this:
 
-	http://www.codemonkey.org.uk/projects/bitkeeper/sparse/
+	$ mkdir -p sparse/.git
+	$ cd sparse
+	$ rsync -a --delete --verbose --stats --progress \
+	  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git/ \
+	  .git
+	$ git-pull-script \
+	  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/sparse.git
+	$ git-read-tree -m HEAD && git-checkout-cache -q -f -u -a
+
+
+If you do not wish to keep the entire git tree around, then DaveJ has
+tarballs at
+
+	http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
 
 
 Once you have it, just do




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbTD3Xgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbTD3Xgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:36:37 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:23328 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262548AbTD3Xge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:36:34 -0400
Date: Wed, 30 Apr 2003 19:46:13 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Kernel source tree splitting
To: linux-kernel@vger.kernel.org
Message-id: <200304301946130000.01139CC8@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eh, Linus won't be happy making a bunch of tarballs.
I've made it less work if you read the message here...

The message mirrored at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105173077417526&w=2

Shows my pre-thought on this subject.  I thought a bit more,
and began to come up with a simple sketch to lead the
way in case anyone becomes interested.

First off, the kernel tarballs would be built by a script
that splits the source tree apart appropriately and tar's it
up.  How this is done is explained.

Second off, there's always a script to download that runs
wget and gets the source tree from which it was downloaded.
The whole thing.  As in, every tarball is downloaded and
untar'd for the user, assembling the full kernel source
tree (as it would be if you untar'd it now).

Now, I explained LOD's in that message above in small
detail.  But, for clarity, LOD's are files which explain
which pieces of source in the kernel tree belong to the
LOD; what gets added to the config; where their makefiles
are; what config options depend on other linux options;
and what groups these LOD's are in.

A command such as `make disttree` should read the LOD's,
split apart each linux option, tar 'em together, and
then compress the tar's.  Then Linus could just scp the
new directory of tar's and a script up.

As for download, the script that goes up can be
downloaded (duh), and then run (... why do I bother?).
Now this script would run in "dumb mode" (unless the
user tells it not to maybe?) and rip down the whole
tree, untar it, and rebuild the original source tree.
I think.  I'm not sure, I really haven't tried yet.
I'll tell you how it works after it's implimented, if
ever that happens.  This would likely require wget.

Of course there's always the ftp method.  Go download
the pieces you want, untar 'em, copy 'em to the same
directory, and the build system adjusts.  but newbies
and developers, for completely opposite reasons, will
want to use the script in dumb mode.

For experienced users, this will make configuration
somewhat easier, as the user can avoid being prompted
for irrelavent drivers.  This is just a concept idea,
not a fully thought-out idea.  What do you think?

--Bluefox Icy



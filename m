Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVEAXiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVEAXiH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 19:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVEAXiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 19:38:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14607 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261444AbVEAXeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 19:34:44 -0400
Date: Mon, 2 May 2005 01:34:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove BK documentation
Message-ID: <20050501233441.GC3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no longer a reason to document the obsolete BK usage.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 9 Apr 2005

 Documentation/00-INDEX                     |    2 
 Documentation/BK-usage/00-INDEX            |   51 ---
 Documentation/BK-usage/bk-kernel-howto.txt |  283 ---------------------
 Documentation/BK-usage/bk-make-sum         |   34 --
 Documentation/BK-usage/bksend              |   36 --
 Documentation/BK-usage/bz64wrap            |   41 ---
 Documentation/BK-usage/cpcset              |   36 --
 Documentation/BK-usage/cset-to-linus       |   49 ---
 Documentation/BK-usage/csets-to-patches    |   44 ---
 Documentation/BK-usage/gcapatch            |    8 
 Documentation/BK-usage/unbz64wrap          |   25 -
 fs/cifs/README                             |    6 
 12 files changed, 3 insertions(+), 612 deletions(-)

--- linux-2.6.12-rc2-mm2-full/Documentation/00-INDEX.old	2005-04-09 19:06:53.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/Documentation/00-INDEX	2005-04-09 19:06:59.000000000 +0200
@@ -12,8 +12,6 @@
 
 00-INDEX
 	- this file.
-BK-usage/
-	- directory with info on BitKeeper.
 BUG-HUNTING
 	- brute force method of doing binary search of patches to find bug.
 Changes
--- linux-2.6.12-rc2-mm2-full/fs/cifs/README.old	2005-04-09 19:08:06.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/fs/cifs/README	2005-04-09 19:08:29.000000000 +0200
@@ -32,9 +32,9 @@
 6) make modules (or "make" if CIFS VFS not to be built as a module)
 
 For Linux 2.6:
-1) Download the kernel (e.g. from http://www.kernel.org or from bitkeeper
-at bk://linux.bkbits.net/linux-2.5) and change directory into the top
-of the kernel directory tree (e.g. /usr/src/linux-2.5.73)
+1) Download the kernel (e.g. from http://www.kernel.org
+and change directory into the top of the kernel directory tree
+(e.g. /usr/src/linux-2.5.73)
 2) make menuconfig (or make xconfig)
 3) select cifs from within the network filesystem choices
 4) save and exit
--- linux-2.6.12-rc2-mm2-full/Documentation/BK-usage/00-INDEX	2005-03-02 08:37:49.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,51 +0,0 @@
-bk-kernel-howto.txt: Description of kernel workflow under BitKeeper
-
-bk-make-sum: Create summary of changesets in one repository and not
-another, typically in preparation to be sent to an upstream maintainer.
-Typical usage:
-	cd my-updated-repo
-	bk-make-sum ~/repo/original-repo
-	mv /tmp/linus.txt ../original-repo.txt
-
-bksend: Create readable text output containing summary of changes, GNU
-patch of the changes, and BK metadata of changes (as needed for proper
-importing into BitKeeper by an upstream maintainer).  This output is
-suitable for emailing BitKeeper changes.  The recipient of this output
-may pipe it directly to 'bk receive'.
-
-bz64wrap: helper script. Uncompressed input is piped to this script,
-which compresses its input, and then outputs the uu-/base64-encoded
-version of the compressed input.
-
-cpcset: Copy changeset between unrelated repositories.
-Attempts to preserve changeset user, user address, description, in
-addition to the changeset (the patch) itself.
-Typical usage:
-	cd my-updated-repo
-	bk changes	# looking for a changeset...
-	cpcset 1.1511 . ../another-repo
-
-csets-to-patches: Produces a delta of two BK repositories, in the form
-of individual files, each containing a single cset as a GNU patch.
-Output is several files, each with the filename "/tmp/rev-$REV.patch"
-Typical usage:
-	cd my-updated-repo
-	bk changes -L ~/repo/original-repo 2>&1 | \
-		perl csets-to-patches
-
-cset-to-linus: Produces a delta of two BK repositories, in the form of
-changeset descriptions, with 'diffstat' output created for each
-individual changset.
-Typical usage:
-	cd my-updated-repo
-	bk changes -L ~/repo/original-repo 2>&1 | \
-		perl cset-to-linus > summary.txt
-
-gcapatch:  Generates patch containing changes in local repository.
-Typical usage:
-	cd my-updated-repo
-	gcapatch > foo.patch
-
-unbz64wrap: Reverse an encoded, compressed data stream created by
-bz64wrap into an uncompressed, typically text/plain output.
-
--- linux-2.6.12-rc2-mm2-full/Documentation/BK-usage/bk-kernel-howto.txt	2005-03-02 08:38:10.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,283 +0,0 @@
-
-		   Doing the BK Thing, Penguin-Style
-
-
-
-
-This set of notes is intended mainly for kernel developers, occasional
-or full-time, but sysadmins and power users may find parts of it useful
-as well.  It assumes at least a basic familiarity with CVS, both at a
-user level (use on the cmd line) and at a higher level (client-server model).
-Due to the author's background, an operation may be described in terms
-of CVS, or in terms of how that operation differs from CVS.
-
-This is -not- intended to be BitKeeper documentation.  Always run
-"bk help <command>" or in X "bk helptool <command>" for reference
-documentation.
-
-
-BitKeeper Concepts
-------------------
-
-In the true nature of the Internet itself, BitKeeper is a distributed
-system.  When applied to revision control, this means doing away with
-client-server, and changing to a parent-child model... essentially
-peer-to-peer.  On the developer's end, this also represents a
-fundamental disruption in the standard workflow of changes, commits,
-and merges.  You will need to take a few minutes to think about
-how to best work under BitKeeper, and re-optimize things a bit.
-In some sense it is a bit radical, because it might described as
-tossing changes out into a maelstrom and having them magically
-land at the right destination... but I'm getting ahead of myself.
-
-Let's start with this progression:
-Each BitKeeper source tree on disk is a repository unto itself.
-Each repository has a parent (except the root/original, of course).
-Each repository contains a set of a changesets ("csets").
-Each cset is one or more changed files, bundled together.
-
-Each tree is a repository, so all changes are checked into the local
-tree.  When a change is checked in, all modified files are grouped
-into a logical unit, the changeset.  Internally, BK links these
-changesets in a tree, representing various converging and diverging
-lines of development.  These changesets are the bread and butter of
-the BK system.
-
-After the concept of changesets, the next thing you need to get used
-to is having multiple copies of source trees lying around.  This -really-
-takes some getting used to, for some people.  Separate source trees
-are the means in BitKeeper by which you delineate parallel lines
-of development, both minor and major.  What would be branches in
-CVS become separate source trees, or "clones" in BitKeeper [heh,
-or Star Wars] terminology.
-
-Clones and changesets are the tools from which most of the power of
-BitKeeper is derived.  As mentioned earlier, each clone has a parent,
-the tree used as the source when the new clone was created.  In a
-CVS-like setup, the parent would be a remote server on the Internet,
-and the child is your local clone of that tree.
-
-Once you have established a common baseline between two source trees --
-a common parent -- then you can merge changesets between those two
-trees with ease.  Merging changes into a tree is called a "pull", and
-is analagous to 'cvs update'.  A pull downloads all the changesets in
-the remote tree you do not have, and merges them.  Sending changes in
-one tree to another tree is called a "push".  Push sends all changes
-in the local tree the remote does not yet have, and merges them.
-
-From these concepts come some initial command examples:
-
-1) bk clone -q http://linux.bkbits.net/linux-2.5 linus-2.5
-Download a 2.5 stock kernel tree, naming it "linus-2.5" in the local dir.
-The "-q" disables listing every single file as it is downloaded.
-
-2) bk clone -ql linus-2.5 alpha-2.5
-Create a separate source tree for the Alpha AXP architecture.
-The "-l" uses hard links instead of copying data, since both trees are
-on the local disk.  You can also replace the above with "bk lclone -q ..."
-
-You only clone a tree -once-.  After cloning the tree lives a long time
-on disk, being updating by pushes and pulls.
-
-3) cd alpha-2.5 ; bk pull http://gkernel.bkbits.net/alpha-2.5
-Download changes in "alpha-2.5" repository which are not present
-in the local repository, and merge them into the source tree.
-
-4) bk -r co -q
-Because every tree is a repository, files must be checked out before
-they will be in their standard places in the source tree.
-
-5)	bk vi fs/inode.c				# example change...
-	bk citool					# checkin, using X tool
-	bk push bk://gkernel@bkbits.net/alpha-2.5	# upload change
-Typical example of a BK sequence that would replace the analagous CVS
-situation,
-	vi fs/inode.c
-	cvs commit
-
-As this is just supposed to be a quick BK intro, for more in-depth
-tutorials, live working demos, and docs, see http://www.bitkeeper.com/
-
-
-
-BK and Kernel Development Workflow
-----------------------------------
-Currently the latest 2.5 tree is available via "bk clone $URL"
-and "bk pull $URL" at http://linux.bkbits.net/linux-2.5
-This should change in a few weeks to a kernel.org URL.
-
-
-A big part of using BitKeeper is organizing the various trees you have
-on your local disk, and organizing the flow of changes among those
-trees, and remote trees.  If one were to graph the relationships between
-a desired BK setup, you are likely to see a few-many-few graph, like
-this:
-
-		    linux-2.5
-		        |
-	       merge-to-linus-2.5
-		 /    |      |
-	        /     |      |
-	vm-hacks  bugfixes  filesys   personal-hacks
-	      \	      |	     |		/
-	       \      |      |         /
-		\     |      |        /
-	         testing-and-validation
-
-Since a "bk push" sends all changes not in the target tree, and
-since a "bk pull" receives all changes not in the source tree, you want
-to make sure you are only pushing specific changes to the desired tree,
-not all changes from "peer parent" trees.  For example, pushing a change
-from the testing-and-validation tree would probably be a bad idea,
-because it will push all changes from vm-hacks, bugfixes, filesys, and
-personal-hacks trees into the target tree.
-
-One would typically work on only one "theme" at a time, either
-vm-hacks or bugfixes or filesys, keeping those changes isolated in
-their own tree during development, and only merge the isolated with
-other changes when going upstream (to Linus or other maintainers) or
-downstream (to your "union" trees, like testing-and-validation above).
-
-It should be noted that some of this separation is not just recommended
-practice, it's actually [for now] -enforced- by BitKeeper.  BitKeeper
-requires that changesets maintain a certain order, which is the reason
-that "bk push" sends all local changesets the remote doesn't have.  This
-separation may look like a lot of wasted disk space at first, but it
-helps when two unrelated changes may "pollute" the same area of code, or
-don't follow the same pace of development, or any other of the standard
-reasons why one creates a development branch.
-
-Small development branches (clones) will appear and disappear:
-
-	-------- A --------- B --------- C --------- D -------
-	          \                                 /
-		   -----short-term devel branch-----
-
-While long-term branches will parallel a tree (or trees), with period
-merge points.  In this first example, we pull from a tree (pulls,
-"\") periodically, such as what occurs when tracking changes in a
-vendor tree, never pushing changes back up the line:
-
-	-------- A --------- B --------- C --------- D -------
-	          \                       \           \
-	           ----long-term devel branch-----------------
-
-And then a more common case in Linux kernel development, a long term
-branch with periodic merges back into the tree (pushes, "/"):
-
-	-------- A --------- B --------- C --------- D -------
-	          \                       \         / \
-	           ----long-term devel branch-----------------
-
-
-
-
-
-Submitting Changes to Linus
----------------------------
-There's a bit of an art, or style, of submitting changes to Linus.
-Since Linus's tree is now (you might say) fully integrated into the
-distributed BitKeeper system, there are several prerequisites to
-properly submitting a BitKeeper change.  All these prereq's are just
-general cleanliness of BK usage, so as people become experts at BK, feel
-free to optimize this process further (assuming Linus agrees, of
-course).
-
-
-
-0) Make sure your tree was originally cloned from the linux-2.5 tree
-created by Linus.  If your tree does not have this as its ancestor, it
-is impossible to reliably exchange changesets.
-
-
-
-1) Pay attention to your commit text.  The commit message that
-accompanies each changeset you submit will live on forever in history,
-and is used by Linus to accurately summarize the changes in each
-pre-patch.  Remember that there is no context, so
-	"fix for new scheduler changes"
-would be too vague, but
-	"fix mips64 arch for new scheduler switch_to(), TIF_xxx semantics"
-would be much better.
-
-You can and should use the command "bk comment -C<rev>" to update the
-commit text, and improve it after the fact.  This is very useful for
-development: poor, quick descriptions during development, which get
-cleaned up using "bk comment" before issuing the "bk push" to submit the
-changes.
-
-
-
-2) Include an Internet-available URL for Linus to pull from, such as
-
-	Pull from:  http://gkernel.bkbits.net/net-drivers-2.5
-
-
-
-3) Include a summary and "diffstat -p1" of each changeset that will be
-downloaded, when Linus issues a "bk pull".  The author auto-generates
-these summaries using "bk changes -L <parent>", to obtain a listing
-of all the pending-to-send changesets, and their commit messages.
-
-It is important to show Linus what he will be downloading when he issues
-a "bk pull", to reduce the time required to sift the changes once they
-are downloaded to Linus's local machine.
-
-IMPORTANT NOTE:  One of the features of BK is that your repository does
-not have to be up to date, in order for Linus to receive your changes.
-It is considered a courtesy to keep your repository fairly recent, to
-lessen any potential merge work Linus may need to do.
-
-
-4) Split up your changes.  Each maintainer<->Linus situation is likely
-to be slightly different here, so take this just as general advice.  The
-author splits up changes according to "themes" when merging with Linus.
-Simultaneous pushes from local development go to special trees which
-exist solely to house changes "queued" for Linus.  Example of the trees:
-
-	net-drivers-2.5 -- on-going net driver maintenance
-	vm-2.5 -- VM-related changes
-	fs-2.5 -- filesystem-related changes
-
-Linus then has much more freedom for pulling changes.  He could (for
-example) issue a "bk pull" on vm-2.5 and fs-2.5 trees, to merge their
-changes, but hold off net-drivers-2.5 because of a change that needs
-more discussion.
-
-Other maintainers may find that a single linus-pull-from tree is
-adequate for passing BK changesets to him.
-
-
-
-Frequently Answered Questions
------------------------------
-1) How do I change the e-mail address shown in the changelog?
-A. When you run "bk citool" or "bk commit", set environment
-   variables BK_USER and BK_HOST to the desired username
-   and host/domain name.
-
-
-2) How do I use tags / get a diff between two kernel versions?
-A. Pass the tags Linus uses to 'bk export'.
-
-ChangeSets are in a forward-progressing order, so it's pretty easy
-to get a snapshot starting and ending at any two points in time.
-Linus puts tags on each release and pre-release, so you could use
-these two examples:
-
-    bk export -tpatch -hdu -rv2.5.4,v2.5.5 | less
-        # creates patch-2.5.5 essentially
-    bk export -tpatch -du -rv2.5.5-pre1,v2.5.5 | less
-        # changes from pre1 to final
-
-A tag is just an alias for a specific changeset... and since changesets
-are ordered, a tag is thus a marker for a specific point in time (or
-specific state of the tree).
-
-
-3) Is there an easy way to generate One Big Patch versus mainline,
-   for my long-lived kernel branch?
-A. Yes.  This requires BK 3.x, though.
-
-	bk export -tpatch -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
-
--- linux-2.6.12-rc2-mm2-full/Documentation/BK-usage/bk-make-sum	2005-03-02 08:37:48.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,34 +0,0 @@
-#!/bin/sh -e
-# DIR=$HOME/BK/axp-2.5
-# cd $DIR
-
-LINUS_REPO=$1
-DIRBASE=`basename $PWD`
-
-{
-cat <<EOT
-Please do a
-
-	bk pull bk://gkernel.bkbits.net/$DIRBASE
-
-This will update the following files:
-
-EOT
-
-bk export -tpatch -hdu -r`bk repogca $LINUS_REPO`,+ | diffstat -p1 2>/dev/null
-
-cat <<EOT
-
-through these ChangeSets:
-
-EOT
-
-bk changes -L -d'$unless(:MERGE:){ChangeSet|:CSETREV:\n}' $LINUS_REPO |
-bk -R prs -h -d'$unless(:MERGE:){<:P:@:HOST:> (:D: :I:)\n$each(:C:){   (:C:)\n}\n}' -
-
-} > /tmp/linus.txt
-
-cat <<EOT
-Mail text in /tmp/linus.txt; please check and send using your favourite
-mailer.
-EOT
--- linux-2.6.12-rc2-mm2-full/Documentation/BK-usage/bksend	2005-04-08 20:57:54.000000000 +0200
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,36 +0,0 @@
-#!/bin/sh
-# A script to format BK changeset output in a manner that is easy to read.
-# Andreas Dilger <adilger@turbolabs.com>  13/02/2002
-#
-# Add diffstat output after Changelog <adilger@turbolabs.com>   21/02/2002
-
-PROG=bksend
-
-usage() {
-	echo "usage: $PROG -r<rev>"
-	echo -e "\twhere <rev> is of the form '1.23', '1.23..', '1.23..1.27',"
-	echo -e "\tor '+' to indicate the most recent revision"
-
-	exit 1
-}
-
-case $1 in
--r) REV=$2; shift ;;
--r*) REV=`echo $1 | sed 's/^-r//'` ;;
-*) echo "$PROG: no revision given, you probably don't want that";;
-esac
-
-[ -z "$REV" ] && usage
-
-echo "You can import this changeset into BK by piping this whole message to:"
-echo "'| bk receive [path to repository]' or apply the patch as usual."
-
-SEP="\n===================================================================\n\n"
-echo -e $SEP
-env PAGER=/bin/cat bk changes -r$REV
-echo
-bk export -tpatch -du -h -r$REV | diffstat
-echo; echo
-bk export -tpatch -du -h -r$REV
-echo -e $SEP
-bk send -wgzip_uu -r$REV -
--- linux-2.6.12-rc2-mm2-full/Documentation/BK-usage/bz64wrap	2005-03-02 08:38:18.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,41 +0,0 @@
-#!/bin/sh
-
-# bz64wrap - the sending side of a bzip2 | base64 stream
-# Andreas Dilger <adilger@clusterfs.com>   Jan 2002
-
-
-PATH=$PATH:/usr/bin:/usr/local/bin:/usr/freeware/bin
-
-# A program to generate base64 encoding on stdout
-BASE64_ENCODE="uuencode -m /dev/stdout"
-BASE64_BEGIN=
-BASE64_END=
-
-BZIP=NO
-BASE64=NO
-
-# Test if we have the bzip program installed
-bzip2 -c /dev/null > /dev/null 2>&1 && BZIP=YES
-
-# Test if uuencode can handle the -m (MIME) encoding option
-$BASE64_ENCODE < /dev/null > /dev/null 2>&1 && BASE64=YES
-
-if [ $BASE64 = NO ]; then
-	BASE64_ENCODE=mimencode
-	BASE64_BEGIN="begin-base64 644 -"
-	BASE64_END="===="
-
-	$BASE64_ENCODE < /dev/null > /dev/null 2>&1 && BASE64=YES
-fi
-
-if [ $BZIP = NO -o $BASE64 = NO ]; then
-	echo "$0: can't use bz64 encoding: bzip2=$BZIP, $BASE64_ENCODE=$BASE64"
-	exit 1
-fi
-
-# Sadly, mimencode does not appear to have good "begin" and "end" markers
-# like uuencode does, and it is picky about getting the right start/end of
-# the base64 stream, so we handle this internally.
-echo "$BASE64_BEGIN"
-bzip2 -9 | $BASE64_ENCODE
-echo "$BASE64_END"
--- linux-2.6.12-rc2-mm2-full/Documentation/BK-usage/cpcset	2005-03-02 08:38:13.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,36 +0,0 @@
-#!/bin/sh
-#
-# Purpose: Copy changeset patch and description from one
-#	   repository to another, unrelated one.
-#
-# usage:  cpcset [revision] [from-repository] [to-repository]
-#
-
-REV=$1
-FROM=$2
-TO=$3
-TMPF=/tmp/cpcset.$$
-
-rm -f $TMPF*
-
-CWD_SAVE=`pwd`
-cd $FROM
-bk changes -r$REV			|	\
-	grep -v '^ChangeSet'		|	\
-	sed -e 's/^  //g' > $TMPF.log
-
-USERHOST=`bk changes -r$REV | grep '^ChangeSet' | awk '{print $4}'`
-export BK_USER=`echo $USERHOST | awk '-F@' '{print $1}'`
-export BK_HOST=`echo $USERHOST | awk '-F@' '{print $2}'`
-
-bk export -tpatch -hdu -r$REV > $TMPF.patch && \
-cd $CWD_SAVE && \
-cd $TO && \
-bk import -tpatch -CFR -y"`cat $TMPF.log`" $TMPF.patch . && \
-bk commit -y"`cat $TMPF.log`"
-
-rm -f $TMPF*
-
-echo changeset $REV copied.
-echo ""
-
--- linux-2.6.12-rc2-mm2-full/Documentation/BK-usage/csets-to-patches	2005-03-02 08:38:26.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,44 +0,0 @@
-#!/usr/bin/perl -w
-
-use strict;
-
-my ($lhs, $rev, $tmp, $rhs, $s);
-my @cset_text = ();
-my @pipe_text = ();
-my $have_cset = 0;
-
-while (<>) {
-	next if /^---/;
-
-	if (($lhs, $tmp, $rhs) = (/^(ChangeSet\@)([^,]+)(, .*)$/)) {
-		&cset_rev if ($have_cset);
-
-		$rev = $tmp;
-		$have_cset = 1;
-
-		push(@cset_text, $_);
-	}
-
-	elsif ($have_cset) {
-		push(@cset_text, $_);
-	}
-}
-&cset_rev if ($have_cset);
-exit(0);
-
-
-sub cset_rev {
-	my $empty_cset = 0;
-
-	system("bk export -tpatch -du -r $rev > /tmp/rev-$rev.patch");
-
-	if (! $empty_cset) {
-		print @cset_text;
-		print @pipe_text;
-		print "\n\n";
-	}
-
-	@pipe_text = ();
-	@cset_text = ();
-}
-
--- linux-2.6.12-rc2-mm2-full/Documentation/BK-usage/cset-to-linus	2005-03-02 08:37:48.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,49 +0,0 @@
-#!/usr/bin/perl -w
-
-use strict;
-
-my ($lhs, $rev, $tmp, $rhs, $s);
-my @cset_text = ();
-my @pipe_text = ();
-my $have_cset = 0;
-
-while (<>) {
-	next if /^---/;
-
-	if (($lhs, $tmp, $rhs) = (/^(ChangeSet\@)([^,]+)(, .*)$/)) {
-		&cset_rev if ($have_cset);
-
-		$rev = $tmp;
-		$have_cset = 1;
-
-		push(@cset_text, $_);
-	}
-
-	elsif ($have_cset) {
-		push(@cset_text, $_);
-	}
-}
-&cset_rev if ($have_cset);
-exit(0);
-
-
-sub cset_rev {
-	my $empty_cset = 0;
-
-	open PIPE, "bk export -tpatch -hdu -r $rev | diffstat -p1 2>/dev/null |" or die;
-	while ($s = <PIPE>) {
-		$empty_cset = 1 if ($s =~ /0 files changed/);
-		push(@pipe_text, $s);
-	}
-	close(PIPE);
-
-	if (! $empty_cset) {
-		print @cset_text;
-		print @pipe_text;
-		print "\n\n";
-	}
-
-	@pipe_text = ();
-	@cset_text = ();
-}
-
--- linux-2.6.12-rc2-mm2-full/Documentation/BK-usage/gcapatch	2005-03-02 08:38:25.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,8 +0,0 @@
-#!/bin/sh
-#
-# Purpose: Generate GNU diff of local changes versus canonical top-of-tree
-#
-# Usage: gcapatch > foo.patch
-#
-
-bk export -tpatch -hdu -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
--- linux-2.6.12-rc2-mm2-full/Documentation/BK-usage/unbz64wrap	2005-03-02 08:38:08.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,25 +0,0 @@
-#!/bin/sh
-
-# unbz64wrap - the receiving side of a bzip2 | base64 stream
-# Andreas Dilger <adilger@clusterfs.com>   Jan 2002
-
-# Sadly, mimencode does not appear to have good "begin" and "end" markers
-# like uuencode does, and it is picky about getting the right start/end of
-# the base64 stream, so we handle this explicitly here.
-
-PATH=$PATH:/usr/bin:/usr/local/bin:/usr/freeware/bin
-
-if mimencode -u < /dev/null > /dev/null 2>&1 ; then
-	SHOW=
-	while read LINE; do
-		case $LINE in
-		begin-base64*) SHOW=YES ;;
-		====) SHOW= ;;
-		*) [ "$SHOW" ] && echo "$LINE" ;;
-		esac
-	done | mimencode -u | bunzip2
-	exit $?
-else
-	cat - | uudecode -o /dev/stdout | bunzip2
-	exit $?
-fi


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWFKQPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWFKQPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 12:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWFKQPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 12:15:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:60222 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932126AbWFKQPU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 12:15:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fqLosDNQSZCMgya5rHDZ8erGymGleX2QoqnrfpwwxaohEkJhbkp88/bjiICXL1C62S9SzDYteOgFtvIL9r0/tCGPWw7JM3hW1r3rYGLLSDiW0CHoQp3SCuKbnqUDASa1Ri0xpoVBOry+bd5pY+fpU9HDJM3mVhyJ/Pcty9/amjw=
Message-ID: <b0943d9e0606110915l767f26d0t1d2dca78c65d51ad@mail.gmail.com>
Date: Sun, 11 Jun 2006 17:15:19 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Stacked GIT 0.10
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stacked GIT 0.10 release is available from http://www.procode.org/stgit/.

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

The main features in this release:

    *  Handle branch names with slashes
    * Testsuite framework
    * Configurable file extensions for merge conflicts
    * 'goto' command, equivalent to 'pop --to' or 'push --to'
    * '--update' option for 'pick' to only fold the changes to files
      already in the current patch
    * '--replace' option for 'import' to replace existing patches in
      the series
    * Look for templates in ~/.stgit/templates as well
    * Allow multiple patch names on the 'push' command line
    * Classify commands in 'stg --help' output
    * Bug fixes

Acknowledgements (generated with 'git shortlog'):

Catalin Marinas:
      Allow git.checkout() to work on unmerged indexes
      Fix the added to both but different conflict
      Fix git.reset() to remove the added files
      Allow configurable file extensions for merge conflicts
      Add the --update option to pick
      Implement the 'goto' command
      Add the --replace option to import
      Fix the t1201-pull-trailing.sh test
      Show the stderr for failed GIT commands
      Generate an empty commit for the newly created patches
      Fix the add and rm commands to fail if no patch is applied
      Fix the t0001-subdir-branches.sh test
      Update the TODO file
      Release 0.10

Karl HasselstrÃ¶m:
      Fix infinite recursion on absolute paths
      Fix indexing error during "diff -r/"
      Explicitly specify utf-8 coding in file

Karl Hasselström:
      Don't die when there are no branches
      Handle branch names with slashes
      Tests for branch names with slashes

Pavel Roskin:
      Add .gitignore files, list generated files there
      Add a simple makefile

Yann Dirson:
      Add a testsuite framework copied from git-core
      Add list of bugs to TODO
      Add a couple of safety checks to series creation
      Make branch creation atomic
      Correctly handle refs/patches on series rename
      Fix a seriously bad interaction between .git caching and repo cloning
      Test that pulls a patch creating a file that got modified afterwards
      Exercise "stg pull" on patches just appending lines.
      Look for templates in ~/.stgit/templates as well
      Fixes to the pull testcases.
      Allow to specify multiple patch names on push command-line
      Classify commands in stg --help output.


-- 
Catalin

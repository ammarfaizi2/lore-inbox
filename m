Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTFGHsy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTFGHsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:48:54 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:35597 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262703AbTFGHsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:48:52 -0400
Date: Sat, 7 Jun 2003 10:02:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Docbook update
Message-ID: <20030607080226.GA8943@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bugzilla.kernel.org has long complained about make *docs (See entry 228).
This updates docbook and some sourcefile to make it compile with success.
When building sgmldocs a lot of warnings are now issued about
parameters with no description. A good sign that comments needs an update.

There is no functional changes in sis900.c and kmod.c - only docbook
related changes.

	Sam

Patches will follow as follow-up mails.

Linus please do a

	bk pull http://linux-sam.bkbits.net/docbook

This will update the following files:

 Documentation/DocBook/Makefile        |   48 ++++++++++++++--------
 Documentation/DocBook/kernel-api.tmpl |    3 -
 drivers/net/sis900.c                  |   72 +++++++++++++++++-----------------
 kernel/kmod.c                         |    2 
 scripts/docproc.c                     |    2 
 scripts/kernel-doc                    |   15 +++++--
 6 files changed, 83 insertions(+), 59 deletions(-)

through these ChangeSets:

<sam@mars.ravnborg.org> (03/06/07 1.1316.1.4)
   docbook: Move definition of MODULENAME_SIZE
   
   The location between the comment and the prototype confused kernel-doc.
   Kernel-doc requires the prototype to follow after the comment section.

<sam@mars.ravnborg.org> (03/06/07 1.1316.1.3)
   docbook: Warn about missing parameter definitions
   
   Previously kernel-doc silently ignored missing parameter descriptions
   but sometimes 'make sgmldocs' failed with exit code > 0.
   When kernel-doc encounter parameters where the description is missing
   it now prints a warning.
   docproc corrected so previously exit code are recorded.
   docbook makefile cleaned up a bit

<sam@mars.ravnborg.org> (03/06/07 1.1316.1.2)
   docbook: Recognize sis900 functions
   
   Adapted comments to follow what kernel-doc (docbook) understands

<sam@mars.ravnborg.org> (03/06/07 1.1316.1.1)
   docbook/kernel-api: include files updated
   
   Path to pci_hotplug_core corrected.
   Added !Eli/string.h to document strlcpy and friends


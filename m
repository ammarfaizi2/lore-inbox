Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUDSVRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUDSVRY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUDSVRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:17:24 -0400
Received: from box.punkt.pl ([217.8.180.66]:4362 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261474AbUDSVRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:17:22 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] linux-libc-headers 2.6.5.0
Date: Mon, 19 Apr 2004 23:16:56 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200404192316.56834.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- updated to 2.6.5 kernel
- numerous fixes all over the place (most notably lvm2 and ax25-tools will 
build out of the box; some other stuff too)
- more docs added

FAQ file follows (I strongly advise all users and vendors to read it):

Q: I've heard that these headers are for PLD Linux Distribution only?
A: It's true that linux-libc-headers where started to get 2.6 kernel based
   PLD version working, but they are, and always will be, vanilla kernel
   compatible. The first three digits of llh's version tag correspond to
   the version of linux kernel of which abi is exported (keep in mind
   there are lots of 2.4 kernel compatibilities included). Any PLD (or any
   other distro for that matter) specific changes are kept away from the
   main tree. So no need to worry (and try not to call them 'pld headers').

Q: Compilation of $INSERTYOURAPP failed after inclusion of linux/config.h
A: The llh package is distribution and kernel configuration agnostic. In an
   ideal world all applications would have runtime detection of what kernel
   does and doesn't support. Unfortunately applications don't do that and in
   some specific situations it's advisable to link your current kernel's
   config file to replace linux/config.h. That error message is there to
   force users to be aware of this situation. Distribution vendors will most
   likely want to remove it.

Q: When compiling $INSERTYOURAPP I got an error message saying I shouldn't
   be including kernel only files.
A: The llh package is for providing userland interfaces. It doesn't contain
   internal kernel definitions. If you get such an error you most likely need
   to fix your app either not to include offending files or to search for
   headers inside kernel sources.
   If you believe your sources are correct mail the maintainer (check AUTHORS
   file for his address) to clear the matter up.

Q: I try to compile $INSERTYOURAPP but some headers were missing/wouldn't
   parse/any other reason resulting in errors. What now?
A: Email the maintainer. Never assume something is broken because the
   maintainer wanted it that way. These headers are still *full* of possible
   errors and that won't change without user feedback.


Enjoy.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again

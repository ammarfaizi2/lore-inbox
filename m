Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265704AbTFNTRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 15:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265705AbTFNTRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 15:17:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:47628 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265704AbTFNTRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 15:17:06 -0400
Date: Sat, 14 Jun 2003 21:30:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: lethal@linux-sh.org
Cc: linux-kernel@vger.kernel.org
Subject: SH Port - Makefile
Message-ID: <20030614193055.GA3673@mars.ravnborg.org>
Mail-Followup-To: lethal@linux-sh.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lethal.

Browsing the changes for SH - which mostly look really good - a few
questions popped up:

>From arch/sh/Makefile:
# We don't necessarily agree with the top-level Makefile with regards to what
# does and does not qualify as a noconfig_targets rule. In this case, we're
# still dependant on .config settings in order for core-y (machdir-y in
# particular) to resolve the proper directory. So we just manually include it
# if it hasn't been already..
#
ifndef include_config
-include .config
endif

Could you elaborate a bit more about this.
I cannot see why core-y is really needed for any noconfig_targets.
Note that "make clean" do not need to descend in all directories to
delete .o files, a find is used for that.


target_links
Will it be possible for SH to implement the scheme used for i386 instead.
We have one symlink today, and I like to keep it down on that level.

arch/sh/tools
Something not yet merged?

BOOTIMAGE
No need to define a variable and then only use it once.

	Sam

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbTLFB4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTLFB4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:56:05 -0500
Received: from dm51.neoplus.adsl.tpnet.pl ([80.54.235.51]:18436 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S264922AbTLFB4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:56:02 -0500
Date: Sat, 6 Dec 2003 03:00:39 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: builtin module aliases in 2.6.0-test11 - non-working MODULE_ALIAS_BLOCKDEV_MAJOR?
Message-ID: <20031206020039.GD3914@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: PLD Linux Distribution
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I see after upgrade to test11 MODULE_ALIAS_CHARDEV_MAJOR has just
begun to work without modprobe.conf entries - but
MODULE_ALIAS_BLOCKDEV_MAJOR hasn't.
At least for floppy module - there is:
MODULE_ALIAS_BLOCKDEV_MAJOR(FLOPPY_MAJOR);
and it means:
$ /sbin/modinfo -F alias floppy
block-major-2-*

But accessing /dev/fd0 still causes modprobe block-major-2, which fails
without block-major-2 alias in /etc/modprobe.conf...


BTW, maybe it would be good to build in some modules more aliases which
seem constant?
I mean (from my modprobe.conf):

alias ppp-compress-21   bsd_comp
alias ppp-compress-24   ppp_deflate
alias ppp-compress-26   ppp_deflate
alias iso9660           isofs
alias block-major-11    sr_mod
alias char-major-21     sg


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

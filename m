Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267287AbUHIVrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUHIVrv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267279AbUHIVru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:47:50 -0400
Received: from 81-5-177-201.dsl.eclipse.net.uk ([81.5.177.201]:18055 "EHLO
	hades.smop.co.uk") by vger.kernel.org with ESMTP id S267292AbUHIVpr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:45:47 -0400
Date: Mon, 9 Aug 2004 22:45:33 +0100
To: linux-kernel@vger.kernel.org
Cc: Maneesh Soni <maneesh@in.ibm.com>
Subject: sysfs patches in -mm create bad permissions
Message-ID: <20040809214533.GA31505@smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Maneesh Soni <maneesh@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Adrian Bridgett <adrian@smop.co.uk>
X-smop-MailScanner: Found to be clean
X-smop-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.9, required 5,
	BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to GregKH for looking at this too. 

Odd one this.  It seems like whoever looks at some files in /sys first, owns
them.  e.g I just created a new user fred, rebooted.  Then "find /sys -user
fred" shows loads of files.  Permissions are 644 and so the owner is
important.

In particular, "echo -n disk > /sys/power/state" will cause the machine to
suspend to disk (hence the security tag).

Found when I suddenly thought, "hang on, shouldn't I be root" :-)

Results so far:

2.6.8-rc2-mm1 - bad
2.6.8-rc2 - okay
2.6.8-rc3 - okay
2.6.8-rc3-mm1 - bad

.config file available on request.  compiled with gcc 3.3.4 (debian 1:3.3.4-6)

Adrian
-- 
Email: adrian@smop.co.uk
Windows NT - Unix in beta-testing. GPG/PGP keys available on public key servers
Debian GNU/Linux  -*-  By professionals for professionals  -*-  www.debian.org

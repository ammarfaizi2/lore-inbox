Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271187AbTG1XLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271163AbTG1XLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:11:48 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:6294 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S270345AbTG1XLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:11:21 -0400
Date: Mon, 28 Jul 2003 19:13:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: dbench has intermittent hang on 2.6.0-test1-ac2
Message-ID: <20030728231310.GA15705@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dbench 32 hang on 2.6.0-test2.  /proc/PID/wchan shows
dbench process in sys_pause, /proc/PPID/wchan shows
other dbench in sys_wait4.

kill -CONT on the two dbench PIDs has the child
wchan change to __pdflush, but the processes don't
appear to continue, nor exit.  After waiting a couple
minutes, I did kill on both PIDs and dbench exited.

This was ext2 filesystem.  Previous was ext3 and 
reiserfs.

sysrq t after "kill -CONT" is at:
http://home.earthlink.net/~rwhron/kernel/sysrq.txt

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html


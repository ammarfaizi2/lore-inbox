Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272822AbTG3LpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272838AbTG3LpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:45:03 -0400
Received: from grouse.mail.pas.earthlink.net ([207.217.120.116]:12718 "EHLO
	grouse.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S272822AbTG3Lo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:44:59 -0400
Date: Wed, 30 Jul 2003 07:46:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: dbench has intermittent hang on 2.6.0-test1-ac2
Message-ID: <20030730114650.GA3244@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
dbench has been intermittantly not completing on uniprocessor.
I run dbench 10 times.  1 of the ten runs has 1 dbench child
that never gets started.  That child is in sys_pause.

2.6.0-test1 and 2.6.0-test1-mm2 did not hang.

2.6.0-test1-ac1, 2.6.0-test1-ac2, 2.6.0-test2, and
2.6.0-test2-mm1 have hung.  So it seems like a patch
that Alan may have picked up first.

The hang has occurred on ext2, ext3, reiserfs, and xfs,
so filesystem type seems unrelated.

pkill -9 dbench will let the processes continue.

dbench version 2.0.

<sysrq-t> from 2.6.0-test2-mm1 before pkill is at:
http://home.earthlink.net/~rwhron/kernel/minicom.cap

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html


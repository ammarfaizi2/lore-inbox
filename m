Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbTDRPjB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 11:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbTDRPjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 11:39:01 -0400
Received: from smtp-out.bhp.t-online.de ([195.145.119.39]:33333 "EHLO
	smtp-out.bhp.t-online.de") by vger.kernel.org with ESMTP
	id S263120AbTDRPjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 11:39:00 -0400
Date: Fri, 18 Apr 2003 18:50:42 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: 2.4.21-pre7, sb->sb_ops->sync_fs
To: lkml <linux-kernel@vger.kernel.org>
Reply-to: tglx@linutronix.de
Message-id: <200304181850.42718.tglx@linutronix.de>
Organization: linutronix
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: KMail/1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a particular reason, why the call to sb->sb_ops->sync_fs in 
2.4.21-pre7 is bound to sb->s_dirt ?

In 2.5 sys_sync finally calls sb->sb_ops->sync_fs wether sb->s_dirt is set or 
not.

-- 
Thomas
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de


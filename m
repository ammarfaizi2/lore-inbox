Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268836AbTGOQkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268449AbTGOQkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:40:41 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:38587 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S268939AbTGOQkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:40:35 -0400
Date: Tue, 15 Jul 2003 18:55:32 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Quota Hash Abstraction 2.4.22-pre6
Message-ID: <20030715165532.GA29282@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@ucw.cz>, linux-kernel@vger.kernel.org
References: <20030715164049.GA27550@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030715164049.GA27550@www.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ooops, as my compiler told me, this trivial patch
is required to compile it with 2.4.22-pre6 8-)

sorry for any inconvenience ...

best,
Herbert


--- linux-2.4.22-pre6-mq0.04/fs/dquot.c 2003-07-15 18:24:14.000000000 +0200
+++ linux-2.4.22-pre6-mq0.04-fix/fs/dquot.c      2003-07-15 18:47:23.000000000 +0200
@@ -434,6 +434,7 @@
        struct list_head *head;
        struct dquot *dquot;
        struct quota_info *dqopt = dqh_dqopt(hash);
+       struct super_block *sb = hash->dqh_sb;
        int cnt;
 
 restart:




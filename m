Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVC1IAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVC1IAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 03:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVC1IAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 03:00:11 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:31454 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S261280AbVC1IAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 03:00:08 -0500
To: linux-kernel@vger.kernel.org
Subject: Off-by-one bug at unix_mkname ?
From: Tetsuo Handa <from-linux-kernel@I-love.sakura.ne.jp>
Message-Id: <200503281700.HHE91205.FtVLOStGOSPMYJFMN@I-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Mon, 28 Mar 2005 17:00:05 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems to me that the following code is off-by-one bug.

http://lxr.linux.no/source/net/unix/af_unix.c#L191
http://lxr.linux.no/source/net/unix/af_unix.c?v=2.4.28#L182

I think
((char *)sunaddr)[len]=0;
should be
((char *)sunaddr)[len-1]=0;


Thanks.

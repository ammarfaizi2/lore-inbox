Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVBHRv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVBHRv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVBHRvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:51:55 -0500
Received: from village.ehouse.ru ([193.111.92.18]:59405 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261609AbVBHRvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:51:40 -0500
From: "Alexander Y. Fomichev" <gluk@php4.ru>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc3-bk5: XFS: fcron: could not write() buf to disk: Resource temporarily unavailable
Date: Tue, 8 Feb 2005 20:51:36 +0300
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502082051.36989.gluk@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G' day

It looks like XFS broken somewhere in 2.6.11-rc1,
sadly i can't sand "right" bugreport, some facts only.
Upgrade to 2.6.11-rc2 makes fcron non-working for me in case of 
crontabs directory is placed on XFS partition.
When i try to install new crontab fcrontab die with error: 
"could not write() buf to disk: Resource temporarily unavailable"

gluk@qa gluk $ crontab test                                                                                                                
20:10:57 installing file /home/gluk/test for user gluk
20:10:57 could not write() buf to disk: Resource temporarily unavailable
20:10:57 Since fcrontab has not been able to save new.gluk's file, it will 
keep the previous version (if any) of new.gluk.
20:10:57 Error while copying file. Aborting.

The same time it works with 2.6.10. Some trick like
mount -o bind from non-xfs (reiserfs in my case) partition helps too. 
some googling shows that similar problem took plase for 2.6.11-rc1 
and postfix:
http://www.webservertalk.com/message879262.html 

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc

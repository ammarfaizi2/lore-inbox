Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268458AbUJOVi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268458AbUJOVi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUJOVi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:38:27 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:4578 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S268458AbUJOViZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:38:25 -0400
Subject: Disk full and writting to pre-allocated area on ReiserFS
From: Peter Zaitsev <peter@mysql.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1097876157.6553.22.camel@sphere.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 14:35:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running SuSE 9.1  Kernel 2.6.5-7.108-default 
But I would guess it applies to large variety of platforms as we have
customers reporting the same problem.

I'm using reiserfs:
/dev/md0 on /data type reiserfs (rw,noatime,notail,data=writeback)

The problem is in case of disk full condition,  "Disk full" error is
being reported even if write happens to Pre-Allocated area, in my case
to Innodb recovery log files.

This is very unfortunate as in such case Innodb has no way but to
terminate database server.  These logs are specially pre-allocated so 
one would not run in such condition.

Question: Is there any way to avoid this problem with Reiserfs ? 


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com




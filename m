Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUCXIX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 03:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbUCXIX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 03:23:58 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:12300 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263084AbUCXIX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 03:23:56 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
Date: Wed, 24 Mar 2004 09:22:57 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040323232511.1346842a.akpm@osdl.org>
In-Reply-To: <20040323232511.1346842a.akpm@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hVUYAvEUCm1kB5t"
Message-Id: <200403240922.57838@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hVUYAvEUCm1kB5t
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 24 March 2004 08:25, Andrew Morton wrote:

Hi Andrew,

> +ext3-journalled-quotas.patch
>  Reintroduce the patch which adds journalling of ext3 quota files.

You keep forgetting this ;)

WARNING: /lib/modules/2.6.5-rc2-mm2/kernel/fs/quota_v2.ko needs unknown symbol 
mark_info_dirty

ciao, Marc

--Boundary-00=_hVUYAvEUCm1kB5t
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.6.5-rc2-mm2-fixups-00-fixup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.5-rc2-mm2-fixups-00-fixup.patch"

--- old/fs/dquot.c	2004-03-24 08:52:42.000000000 +0100
+++ new/fs/dquot.c	2004-03-24 09:21:30.000000000 +0100
@@ -286,7 +286,7 @@ void mark_info_dirty(struct super_block 
 {
 	set_bit(DQF_INFO_DIRTY_B, &sb_dqopt(sb)->info[type].dqi_flags);
 }
-
+EXPORT_SYMBOL(mark_info_dirty);
 
 /*
  *	Read dquot from disk and alloc space for it

--Boundary-00=_hVUYAvEUCm1kB5t--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbUL0TsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbUL0TsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbUL0Trx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:47:53 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:16292 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261962AbUL0Tqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:46:40 -0500
Date: Mon, 27 Dec 2004 20:46:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: About NFS4 in kernel 2.6.9
In-Reply-To: <d5a95e6d04122711355a0a9b04@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0412272045020.9354@yvahk01.tjqt.qr>
References: <d5a95e6d04122711183596d0c8@mail.gmail.com>  <20041227192508.GC18869@freenet.de>
 <d5a95e6d04122711355a0a9b04@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-507316178-1104176798=:9354"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-507316178-1104176798=:9354
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>First sorry about my poor english. I read in internet that it´s best
>if i recompile NFS4 as module, so i did it. But i have this error
>message. I dont know wht to do. when i do make xconfig, in filesystem,
>i have checked all that have NFS and RPC, but it insist in not work.

Really? I have this in fs/Kconfig (2.6.8+2.6.9-rc2):

menu "Network File Systems"
        depends on NET
          
config NFS_FS
        tristate "NFS file system support"
        depends on INET
        select LOCKD
        select SUNRPC
        select NFS_ACL_SUPPORT if NFS_ACL


So SUNRPC should always be selected whenever you say yes/module to "NFS file 
system support".
Check the .config if NFS_FS=y or =m, that'd be my guess.



Jan Engelhardt
-- 
ENOSPC
--1283855629-507316178-1104176798=:9354--

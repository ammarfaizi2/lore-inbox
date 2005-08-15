Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVHOXkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVHOXkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVHOXkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:40:32 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:47498 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S965036AbVHOXkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:40:32 -0400
Date: Tue, 16 Aug 2005 03:40:26 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: linux-kernel@vger.kernel.org
Subject: idr_remove error with 2.6.13-rc6
Message-ID: <20050815234026.GA6036@tentacle.sectorb.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.11-ac7
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! I saw the following in the logs:
=== START
idr_remove called for id=200 which is not allocated.

Call Trace:<ffffffff8014abb0>{autoremove_wake_function+0} <ffffffff8023ee5f>{sub_remove+239}
       <ffffffff8023ee99>{idr_remove+41} <ffffffff802599b7>{release_dev+1815}
       <ffffffff801a1e42>{inotify_dentry_parent_queue_event+66}
       <ffffffff80191941>{dput+33} <ffffffff80259f41>{tty_release+17}
       <ffffffff8017a75a>{__fput+154} <ffffffff80178f3e>{filp_close+110}
       <ffffffff80136d53>{put_files_struct+115} <ffffffff80137ba9>{do_exit+489}
       <ffffffff80137f00>{sys_exit_group+0} <ffffffff801221c1>{ia32_sysret+0}
=== END
AFAICT this caused no harm.       
The box is dual Opteron with 64-bit kernel and mixed userland.
I saw a similar trace once with 2.6.13-rc5 too.

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 


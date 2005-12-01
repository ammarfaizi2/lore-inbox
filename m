Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVLAMvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVLAMvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVLAMvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:51:01 -0500
Received: from networks.syneticon.net ([213.239.212.131]:36033 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP id S932196AbVLAMvA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:51:00 -0500
Message-ID: <438EF1AA.7040806@wpkg.org>
Date: Thu, 01 Dec 2005 13:50:50 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mozilla Thunderbird 1.0.7-3mdk (X11/20051015)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Norbert van Nobelen <norbert-kernel@hipersonik.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loadavg always equal or above 1.00 - how to explain?
References: <438EE515.1080001@wpkg.org> <200512011330.32435.norbert-kernel@hipersonik.com>
In-Reply-To: <200512011330.32435.norbert-kernel@hipersonik.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert van Nobelen schrieb:
> Can you use top to determine which process is requesting most of the CPU? 

Actually, when I press shift + P in top, top is the most used process 
for a while - around 1%, then it drops to ~ 0.0-0.3% and stays like 
that; other processes (like sshd, smbd) don't take more than ~0.5% 
really few times a minute.

Same goes with memory usage.

vmstat output:

procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
sy id wa
  2  0  14612  69748  26112 184004    0    0     1     1    3     3  3 
3 94  0


iostat output:

avg-cpu:  %user   %nice    %sys %iowait   %idle
            1,79    1,52    2,66    0,33   93,70

Device:            tps   Blk_read/s   Blk_wrtn/s   Blk_read   Blk_wrtn
hda               2,51        49,99        50,09  538412978  539475864
hdb               0,00         0,00         0,00       1744          0
fd0               0,00         0,00         0,00          6          0


-- 
Tomek
http://wpkg.org
WPKG - software deployment and upgrades with Samba

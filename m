Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUISWZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUISWZy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 18:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUISWZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 18:25:54 -0400
Received: from jaures31-1-82-228-83-187.fbx.proxad.net ([82.228.83.187]:59962
	"HELO valhalla.trou.net") by vger.kernel.org with SMTP
	id S264668AbUISWZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 18:25:53 -0400
Message-ID: <414E076F.5010801@twilight-hall.net>
Date: Mon, 20 Sep 2004 00:25:51 +0200
From: =?ISO-8859-1?Q?Rapha=EBl_Rigo?= <raphael.rigo@twilight-hall.net>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040917)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RAID1 Bug] bio too big device md0 (248 > 200) (2.6.9-rc2-mm1)
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
kernel version : 2.6.9-rc2-mm1
i'm using a RAID1 array over 2 disks : one ATA, and another one in 
"SATA" (if we can call the ICH5 a real SATA controller).
During array synchronisation, I get "bio too big device md0 (248 > 200)" 
error, which I fixed in doing
//#define RESYNC_BLOCK_SIZE (64*1024)
#define RESYNC_BLOCK_SIZE PAGE_SIZE
in raid1.c, following the instruction on an old thread (for kernel 2.6.0).
I would like to know if there is any better fix now, else then this mail 
  will act as a remainder ;)

Raphaël Rigo

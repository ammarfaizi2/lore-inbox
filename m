Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSGPM5t>; Tue, 16 Jul 2002 08:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317854AbSGPM5s>; Tue, 16 Jul 2002 08:57:48 -0400
Received: from mrelay.jrc.it ([139.191.1.65]:43204 "EHLO mrelay.jrc.it")
	by vger.kernel.org with ESMTP id <S317852AbSGPM5r>;
	Tue, 16 Jul 2002 08:57:47 -0400
Message-ID: <3D3418F6.5000003@jrc.it>
Date: Tue, 16 Jul 2002 15:00:38 +0200
From: Wolfgang Mehl <wolfgang.mehl@jrc.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-gb, en-us, de, it, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compile error in vmlinux-2.4.19-rc1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In module init/do_mounts.c I get error "undefined symbol change_floppy" 
when CONFIG_BLK_DEV_RAM=y and CONFIG_BLK_DEV_FD=m.
The error can be corrected with the following patch

381c381
< #if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
---
 > #if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)

best regards
Wolfgang



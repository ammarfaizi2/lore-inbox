Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316438AbSEOQny>; Wed, 15 May 2002 12:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316439AbSEOQnx>; Wed, 15 May 2002 12:43:53 -0400
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:12416 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316438AbSEOQnw>; Wed, 15 May 2002 12:43:52 -0400
Date: Wed, 15 May 2002 18:43:43 +0200
From: Edouard Gomez <ed.gomez@wanadoo.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [BUG] Ramdisk is broken with 2.4.19-pre6/8
Message-ID: <20020515164343.GA412@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've build a 2 disk set following the http://www.tldp.org/HOWTO/Bootdisk-HOWTO/
instructions. This works well with < 2.4.19-pre6 kernels but 2.4.19-pre6 just
doesn't read the 2nd floppy disk (the ramdisk).

I noticed that 2.4.19-pre6 try to read from floppy before prompting for the
ramdisk and <2.4.19-pre6 never did that.

Once i press enter with the 2.4.19-pre6, the kernel seems to do nothing. No
kernel panic, no oops. It just does nothing. The floppy leds is switched on
3s or 5s and then is switched off.

Alt+SysRq+T gives me 5 usual tasks in Sleeping mode :
[ksoftirqd_CPU0]
[kswapd]
[kupdated]
[keventd]
[bdflush]
and one active task called swapper (never heard about that one).
This last task is still in R state.

This bug is still present in 2.4.19-pre8 (tested, same behaviour).

Regards

PS : Can you cc me the answers as i not a lkml subscriber. Thx

-- 
Edouard Gomez

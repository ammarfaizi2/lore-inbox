Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSGXOyQ>; Wed, 24 Jul 2002 10:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317314AbSGXOyQ>; Wed, 24 Jul 2002 10:54:16 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.130]:59092 "EHLO
	moutvdomng0.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317312AbSGXOyP>; Wed, 24 Jul 2002 10:54:15 -0400
Date: Wed, 24 Jul 2002 08:57:09 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alex Riesen <Alexander.Riesen@synopsys.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.28 (linus' bk): conflicting KEY_xxx macros
In-Reply-To: <20020724144804.GE14143@riesen-pc.gr05.synopsys.com>
Message-ID: <Pine.LNX.4.44.0207240854590.3472-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, Alex Riesen wrote:
> include/linux/input.h has this:
> 
> #define KEY_PLAY	207
> #define KEY_FASTFORWARD	    208
> 
> #define KEY_PLAY	0x197
> #define KEY_FASTFORWARD	    0x19b
> 
> which one is where?

The second ones override the first ones, so we just drop the first ones 
(since the seconds seem to have worked well for some time):

--- linus-2.5/include/linux/input.h     2002-07-16 10:01:54.000000000 
-0600
+++ thunder-2.5/include/linux/input.h   2002-07-24 08:55:53.000000000 
-0600
@@ -307,8 +307,6 @@
 #define KEY_PROG4              203
 #define KEY_SUSPEND            205
 #define KEY_CLOSE              206
-#define KEY_PLAY               207
-#define KEY_FASTFORWARD                208
 #define KEY_BASSBOOST          209
 #define KEY_PRINT              210
 #define KEY_HP                 211


							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------


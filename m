Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263271AbSJCNfN>; Thu, 3 Oct 2002 09:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263287AbSJCNfN>; Thu, 3 Oct 2002 09:35:13 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:48861 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263271AbSJCNfL>;
	Thu, 3 Oct 2002 09:35:11 -0400
Date: Thu, 3 Oct 2002 15:40:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, tori@ringstrom.mine.nu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: AT keyboard input problem
Message-ID: <20021003154037.A39176@ucw.cz>
References: <20021003144319.A38785@ucw.cz> <200210031320.g93DKnqx000460@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210031320.g93DKnqx000460@darkstar.example.net>; from jbradford@dial.pipex.com on Thu, Oct 03, 2002 at 02:20:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 02:20:48PM +0100, jbradford@dial.pipex.com wrote:

> Control
> ALT, (it says, 'Kanji/Katakana/Kanji???', but works as ALT)
> Scancode 0x85 
> Space bar
> Scancode 0x86
> Scancode 0x87, (it says, 'Hiragana/Roma characters')
> ALT GR
> Control

0x85 - Intl5 - Muhenkan
0x86 - Intl4 - Henkan
0x87 - Intl2 - Hiragana/Katakana

Added, patch:

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Oct  3 15:38:22 2002
+++ b/drivers/input/keyboard/atkbd.c	Thu Oct  3 15:38:22 2002
@@ -73,7 +73,7 @@
 	113,114, 40, 84, 26, 13, 87, 99,100, 54, 28, 27, 43, 84, 88, 70,
 	108,105,119,103,111,107, 14,110,  0, 79,106, 75, 71,109,102,104,
 	 82, 83, 80, 76, 77, 72, 69, 98,  0, 96, 81,  0, 78, 73, 55, 85,
-	 89, 90, 91, 92, 74,  0,  0,  0,  0,  0,  0,125,126,127,112,  0,
+	 89, 90, 91, 92, 74,185,184,182,  0,  0,  0,125,126,127,112,  0,
 	  0,139,150,163,165,115,152,150,166,140,160,154,113,114,167,168,
 	148,149,147,140,  0,  0,  0,  0,  0,  0,251,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,

-- 
Vojtech Pavlik
SuSE Labs

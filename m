Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbTFCKKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 06:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbTFCKKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 06:10:17 -0400
Received: from mpsb-nat02.plala.or.jp ([202.212.114.145]:47067 "EHLO
	mps2.plala.or.jp") by vger.kernel.org with ESMTP id S264887AbTFCKKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 06:10:15 -0400
Date: Tue, 03 Jun 2003 19:23:41 +0900
From: <yokotak@rmail.plala.or.jp>
X-Mailer: EdMax Ver2.85.2F
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: multiple psx pads with gamecon
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20030603102340.ZVFR3591.mps2.plala.or.jp@rmail.mail.plala.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I post carbon copy to linux-kernel and joystick guru on my own
judgment. Please forgive me.
> Hi, I was reading your thread on gamecon development and thought you might
> be able to help me.  I have 2 psx pads hooked up to my printer port which
> both work fine in windows but can only get one working in linux.
(...)
> modprobe gamecon gc=0,7,7
> 
> When I test the 2nd pad using  od -xw8 /dev/input/js1 I get:
> /dev/input/js1: No such device
> but I verified and js1 is there.

Your procedure seems to be perfect. Your problem is not caused by your
miss, but by gamecon.c specification.

There are several varieties in DPP-style pararrel connector. Each 1P
are same, but 2P+ are differant. Your DPP is 1 or 2 perhaps. Gamecon.c
seems to support 3 (SNESkey psx). I am sorry, I can not help you.

1. DPP standard (1P-2P)
  http://www.arcadecontrols.com/Mirrors/www.ziplabel.com/dpadpro/psx.html
1-1. DPP standard + unmodified multitap (1P-4P)
  http://web.archive.org/web/20011123185146/http://www.geocities.co.jp/SiliconValley/2650/ps_multi.html
  http://www.geocities.co.jp/SiliconValley/2650/dpp_mlt.lzh

2. DPP multitap (1P-5P, also called "mega-tap")
  http://clear-blue.ath.cx/sasab/dpp/img/cab_multi.gif
  
3. SNESkey psx (1P-5P, gamecon.c psx)
  http://www.arcadecontrols.com/Mirrors/www.csc.tntech.edu/~jbyork/default.htm
  http://www.charmed.com/support/kernel/docs/joystick-parport.txt

Thank you for your reading,
  yokota


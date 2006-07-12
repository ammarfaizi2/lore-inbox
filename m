Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWGLMh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWGLMh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWGLMh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:37:57 -0400
Received: from gherkin.frus.com ([192.158.254.49]:11534 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1751185AbWGLMh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:37:56 -0400
Subject: [BUG] alpha: Xorg 7.0.22 causes Oops and lockup
To: linux-kernel@vger.kernel.org
Date: Wed, 12 Jul 2006 07:37:55 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060712123755.85D4EDBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached Oops output is from an Alpha system (Miata: PWS 433au).

Problem: attempting to run Xorg 7.0.X with 2.6.18-rc1 kernel causes
    an Oops and a hard lockup.  Monitor powers down immediately and
    must hit system reset switch to recover.

Repeat by: allowing gdm to start after booting.  "X -probeonly" seems
    safe as far as not causing the lockup.

Additional info:
    graphics card is a Radeon 7500 (PCI).  System boots with
    "radeonfb" driver built-in using either default resolution or
    "1024x768-16@70" (chosen resolution does not affect outcome).
    "radeon" driver specified in "xorg.conf".

 Xorg(3283): Oops 0
 pc = [cia_machine_check+112/176]  ra = [do_entInt+308/384]  ps = 0007    Not tainted
 pc is at cia_machine_check+0x70/0xb0
 ra is at do_entInt+0x134/0x180
 v0 = 0000000000000001  t0 = 0000000000000001  t1 = 0000000000000660
 t2 = 0000000000000001  t3 = 0000000000000000  t4 = 0000000000000001
 t5 = 000002000033fa70  t6 = cccccccccccccccd  t7 = fffffc001c2bc000
 s0 = fffffc001c2bfee8  s1 = 000000012039e820  s2 = 000000012039ded0
 s3 = 000000012039e868  s4 = 0000020000aac000  s5 = 0000000120397640
 s6 = 0000000120397640
 a0 = 0000000000000660  a1 = 0000000000000000  a2 = fffffc001c2bfee8
 a3 = fffffc00005c65ba  a4 = 0000000000000000  a5 = 0000008810000000
 t8 = fffffc001c2c0000  t9 = 00000200002d41d8  t10= 0000000000000008
 t11= 0000000000000001  pv = fffffc000031d7e0  at = 00000000041df8f4
 gp = fffffc00006e6b00  sp = fffffc001c2bfec8
 Trace:
 [do_entInt+308/384] do_entInt+0x134/0x180
 [ret_from_sys_call+0/16] ret_from_sys_call+0x0/0x10
 [entInt+0/128] entInt+0x0/0x80
 
 Code: 2a810000  406205a3  2273faba  428015a1  44230001  e4200007 <a031000c> 247f8000 

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

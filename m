Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUBUXY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 18:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUBUXY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 18:24:27 -0500
Received: from woland.ws ([62.121.81.218]:31242 "EHLO woland.michal.waw.pl")
	by vger.kernel.org with ESMTP id S261627AbUBUXY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 18:24:26 -0500
Date: Sun, 22 Feb 2004 00:24:16 +0100
From: Michal Kochanowicz <michal@michal.waw.pl>
To: linux-kernel@vger.kernel.org
Subject: v4l fails after on 2.6.3 (works on 2.6.2)
Message-ID: <20040221232416.GI7775@woland.michal.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Organization: Happy GNU/Linux Users
X-Signature-Tagline-Copyright: Piotr Zientarski, 1999-2001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After upgrade of kernel 2.6.2 -> 2.6.3 (built from exactly the same
config) I'm no longer able to use my TV tuner card. When I launch tvtime
following appears in system log:
kernel: tuner: Huh? tv_set is NULL?

tvtime reports that "there is no signal" and when I try to change the
channel, following appears in the log:
kernel: bttv0: skipped frame. no signal? high irq latency? [main=1bd24000,o_vbi=1bd24018,o_field=e74c000,rc=ee9c3e0]
kernel: bttv0: skipped frame. no signal? high irq latency? [main=1bd24000,o_vbi=1bd24018,o_field=e74e000,rc=e74e024]
kernel: bttv0: skipped frame. no signal? high irq latency? [main=1bd24000,o_vbi=1bd24018,o_field=e74e000,rc=e74e01c]
kernel: bttv0: skipped frame. no signal? high irq latency? [main=1bd24000,o_vbi=1bd24018,o_field=e750000,rc=e75001c]
kernel: bttv0: skipped frame. no signal? high irq latency? [main=1bd24000,o_vbi=1bd24018,o_field=e750000,rc=eb8d340]
kernel: tuner: Huh? tv_set is NULL?

The tuner is some Prolink card based on BT878. It still works when I
boot 2.6.2 (with following settings in modules.conf:
options tuner type=5
options bttv card=16
).

Is there any chance for this to be fixed?

Regards
-- 
--= Michal Kochanowicz =--==--==BOFH==--==--= michal@michal.waw.pl =--
--= finger me for PGP public key or visit http://michal.waw.pl/PGP =--
--==--==--==--==--==-- Vodka. Connecting people.--==--==--==--==--==--
A chodzenie po górach SSIE!!!

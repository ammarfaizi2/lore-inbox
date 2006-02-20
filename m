Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbWBTUDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWBTUDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWBTUDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:03:34 -0500
Received: from mail.linicks.net ([217.204.244.146]:60621 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932672AbWBTUDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:03:33 -0500
From: Nick Warne <nick@linicks.net>
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: i386 AT keyboard LED question.
Date: Mon, 20 Feb 2006 20:03:26 +0000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602202003.26642.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I wondered why numlock LED goes off during boot process, even though I ask 
BIOS to turn on;

atkbd.c

/*
 * If the get ID command failed, we check if we can at least set the LEDs on
 * the keyboard. This should work on every keyboard out there. It also turns
 * the LEDs off, which we want anyway.
 */
                param[0] = 0;
                if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
                        return -1;


What is the rationale *why* we want LEDS off anyway?

Thanks,

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270097AbTGXUNT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 16:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270436AbTGXUNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 16:13:19 -0400
Received: from pop.gmx.net ([213.165.64.20]:39637 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270097AbTGXUNM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 16:13:12 -0400
From: Michael Schierl <schierlm-usenet@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: touchpad doesn't work under 2.6.0-test1-ac2
Date: Thu, 24 Jul 2003 22:27:51 +0200
Reply-To: schierlm@gmx.de
References: <bXg8.4Wg.1@gated-at.bofh.it>
In-Reply-To: <bXg8.4Wg.1@gated-at.bofh.it>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-Id: <S270097AbTGXUNM/20030724201313Z+7864@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Benfell <benfell@greybeard95a.com> wrote:

>Hello all,
>
>Finally decided to give a development kernel a try on an HP zt1180
>laptop.  The kernel build went smoothly and I thought all was well
>(well except I guess I've gotta figure out frame buffer support again)
>until I started X and discovered that the mouse wasn't working.

same for me under 'vanilla' 2.6.0-test1.

However, giving 'psmouse_noext' as kernel param helped for me to make
the touchpad work (using /dev/input/mice (protocol autops2) as source
for gpm and gpm repeater as source for x, as I did in 2.4.x kernels).

Setting "#define DEBUG" in drivers/input/serio/i8042.c caused lots of
lines of text on my console whenever i touched either the touchpad or
one of the (four) buttons.

with 'psmouse_noext' it creates less lines on my console, and only for
two buttons, not for the other two.

HTH,

Michael
-- 
"New" PGP Key! User ID: Michael Schierl <schierlm@gmx.de>
Key ID: 0x58B48CDD    Size: 2048    Created: 26.03.2002
Fingerprint:  68CE B807 E315 D14B  7461 5539 C90F 7CC8
http://home.arcor.de/mschierlm/mschierlm.asc

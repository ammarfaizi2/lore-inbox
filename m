Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277237AbRJNSJq>; Sun, 14 Oct 2001 14:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277261AbRJNSJg>; Sun, 14 Oct 2001 14:09:36 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:51212 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S277237AbRJNSJY>; Sun, 14 Oct 2001 14:09:24 -0400
From: thunder7@xs4all.nl
Date: Sun, 14 Oct 2001 20:07:19 +0200
To: linux-kernel@vger.kernel.org
Subject: NR_IRQS when CONFIG_ALPHA_GENERIC is chosen
Message-ID: <20011014200719.A1758@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you compile an alpha kernel for CONFIG_ALPHA_GENERIC, NR_IRQS is
set at 2048. Comment in include/arch-alpha/irq.h: 'Enough for WILDFIRE
WITH 8 QBB's'. I'm not sure what a QBB is (Quality BarBecue?) but 2048
interrupts is ridiculous, and overloads /proc/stat.

A /proc/stat that is that long crashes several user-space programs, like
vmstat, xosview etc.

The reason I use CONFIG_ALPHA_GENERIC is that I get keyboard timeouts
in dmesg at boot-time when I use CONFIG_ALPHA_MIATA, with every kernel >
2.4.9-ac-x; I've not tested earlier.

The alpha kernel mailing-list seems dead.

Is there some reason to keep NR_IRQ at 2048? I'd assume a
CONFIG_ALPHA_GENERIC kernel is a lot more common than a Wildfire with 8
QBB's, so it would be better to tone it down a little. Also, can anybody
point me at some good ways to debug that keyboard timeout?

Thanks,
Jurriaan
-- 
HORROR FILM WISDOM:
9. If your car runs out of gas at night, do not go to the nearby
deserted-looking house to phone for help.
GNU/Linux 2.4.10-ac12 SMP/ReiserFS 2x1402 bogomips load av: 0.06 0.11 0.05

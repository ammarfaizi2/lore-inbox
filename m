Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265427AbUAUO1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 09:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbUAUO1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 09:27:32 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:22981 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S265427AbUAUO1b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 09:27:31 -0500
Date: Wed, 21 Jan 2004 15:27:28 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: i830 agpgart oddities
Message-ID: <20040121142728.GC1499@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

does anyone have an idea about following odd reset?

I've tried suspend-to-disk. If I'm using agpgart and X server then resume simply
resets whole system (no oops).
If I change resume so that it restores pages from higher addresses to lower then
it is all ok.
If I start restoring at 0xc0000000 and ending at 0xcee00000 then it resets at
about 0xcb8ab000.  If I start restoring at 0xcee00000 down to 0xc0000000 then it
is ok and system is back ok as well.

I have no idea why it depends on order of pages while interrupts are disabled
and I'm only copying memory pages.

-- 
Luká¹ Hejtmánek

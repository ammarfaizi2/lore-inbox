Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269467AbRGaVUn>; Tue, 31 Jul 2001 17:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269472AbRGaVUd>; Tue, 31 Jul 2001 17:20:33 -0400
Received: from Bf824.pppool.de ([213.7.248.36]:5248 "HELO finnegan")
	by vger.kernel.org with SMTP id <S269467AbRGaVUR>;
	Tue, 31 Jul 2001 17:20:17 -0400
Date: Tue, 31 Jul 2001 23:20:18 +0200 (CEST)
From: Peter Koellner <peter@mezzo.net>
To: linux-kernel@vger.kernel.org
Subject: broken apm-bios in sony vaio fx209k, continued
Message-ID: <Pine.LNX.4.21.0107312308370.648-100000@finnegan.do.mezzo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

now it looks as if the apm bios really is broken, not a simple
hi/lo swap as in several other vaios.

this is a phoenix bios, code R0211U0.
it claims to be an apm bios 1.2.

the APM BIOS call "get power status" for all devices reports that there 
is no battery installed, and "get power status" for device 0x8000 or 0x8001 
(battery) returns an error which is reported as "power status not available".
so the apm bios is convinced that there is no battery at all.

i don't have too much experience with the power management system, 
but i guess this means that only acpi will work here, which at current 
doesn't. 

any suggestions?

-- 
peter koellner <peter@mezzo.net>



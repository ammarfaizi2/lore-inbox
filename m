Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbRHBImf>; Thu, 2 Aug 2001 04:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268854AbRHBImZ>; Thu, 2 Aug 2001 04:42:25 -0400
Received: from cleitus.hosting.pacbell.net ([216.100.99.17]:28117 "EHLO
	cleitus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S268715AbRHBImU>; Thu, 2 Aug 2001 04:42:20 -0400
From: "Daniel Glozman" <daniel@simpod.com>
To: <andy@waldorf-gmbh.de>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>
Cc: "Rami Gideoni" <Rami@simpod.com>, "Yiftach Tzori" <yiftach@simpod.com>
Subject: Bug report
Date: Thu, 2 Aug 2001 11:38:17 +0200
Message-ID: <NEBBLPMJIKEFMJAAABPAGEPECCAA.daniel@simpod.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,
I was using the arch/mips/kernel/gdb-stub.c,v 1.6 file on the mips Opal design with Little Endian format. I found out that step
function was not working properly. So I debugged  little and found out the problem:
On line: 536, it says:

 	if (is_cond && targ != (regs->cp0_epc + 8)) {

The targ and regs->cp0_epc are unsigned integers and "8" is signed by default.
So what happend is that the condition didn't work as it is expected.

Please consider it in your feature versions.

Daniel.



---------------------------------
Daniel Glozman  daniel@simpod.com
SimPOD Inc.      www.simpod.com
Tel :  +972-4-9937770/203


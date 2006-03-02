Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWCBUTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWCBUTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWCBUTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:19:52 -0500
Received: from wsip-68-14-232-151.ph.ph.cox.net ([68.14.232.151]:3977 "EHLO
	cantor.snitselaar.org") by vger.kernel.org with ESMTP
	id S932295AbWCBUTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:19:52 -0500
Message-ID: <19805.198.115.32.5.1141330790.squirrel@cantor.snitselaar.org>
Date: Thu, 2 Mar 2006 13:19:50 -0700 (MST)
Subject: Question about inline assembly for BUG()
From: "Gerard Snitselaar" <snits@snitselaar.org>
To: linux-kernel@vger.kernel.org
Reply-To: snits@snitselaar.org
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20050812.1.fc4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the following asm will anything show up in the actual
code besides the ud2 opcode (0x0f0b) ? Is there any good references
for inline assembly besides "Brennan's Guide to Inline Assembly" ?
Thanks

#define BUG()				\
 __asm__ __volatile__(	"ud2\n"		\
			"\t.word %c0\n"	\
			"\t.long %c1\n"	\
			 : : "i" (__LINE__), "i" (__FILE__))


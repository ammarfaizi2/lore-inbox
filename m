Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270543AbTGUQrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270544AbTGUQrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:47:14 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:35500
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S270543AbTGUQrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:47:10 -0400
Message-ID: <32425.216.12.38.216.1058806931.squirrel@www.ghz.cc>
In-Reply-To: <20030721163517.GA597@www0.org>
References: <20030721163517.GA597@www0.org>
Date: Mon, 21 Jul 2003 13:02:11 -0400 (EDT)
Subject: Re: 2.6.0-test1 won't go further than "uncompressing" on a p1/32MB 
     pc
From: "Charles Lepple" <clepple@ghz.cc>
To: "michaelm" <admin@www0.org>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

michaelm said:
> That is on a p1 150MMX 32MB PC, specifically an IBM ThinkPad 560E. It

I just did a diff between your configuration, and that of my ThinkPad 770
(233 MHz Pentium MMX).

Note to defconfig maintainers: can these options be enabled by default on
i386 (like they were in 2.4)?

Things that you might want to enable:

CONFIG_ISA=y

CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_AT_KEYBOARD=y

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

You also might want to turn off Trident FB support, and turn on generic
VESA support. I have had good luck with the VESA driver, but odd,
irreproducible errors with the Trident code (several versions back;
haven't retested).

-- 
Charles Lepple <ghz.cc!clepple>
http://www.ghz.cc/charles/

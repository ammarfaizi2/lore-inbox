Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUG1Kqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUG1Kqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 06:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUG1Kqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 06:46:45 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:52241 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S266879AbUG1Kql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 06:46:41 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Subject: Re: IPMI watchdog question
Date: Wed, 28 Jul 2004 12:46:27 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, minyard@acm.org
References: <Pine.LNX.4.58.0407280901330.31636@praktifix.dwd.de> <200407281129.22431.arekm@pld-linux.org> <Pine.LNX.4.58.0407281021530.31636@praktifix.dwd.de>
In-Reply-To: <Pine.LNX.4.58.0407281021530.31636@praktifix.dwd.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407281246.27304.arekm@pld-linux.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Points assigned by spam scoring system to this email. Note that message
	is treated as spam ONLY if X-Spam-Flag header is set to YES.
	If you have any report questions, see report postmaster@beep.pl for details.
	Content analysis details:   (0.0 points, 25.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 of July 2004 12:33, Holger Kiehl wrote:

> > Do you have CONFIG_WATCHDOG_NOWAYOUT enabled?
>
> No this is not set. Must this be set? Actually I want that one can stop the
> watchdog gracefully. And this is done by writting a 'V' to /dev/watchdog,
> correct?
Without CONFIG_WATCHDOG_NOWAYOUT (or nowayout=1 module option added by my 
patch just sent to lkml) when /dev/watchdog is closed then watchdog timer is 
disabled.

> I noticed that CONFIG_WATCHDOG is also not set since CONFIG_IPMI_WATCHDOG
> is set under IPMI. Must this be set?
Currently these two are unrelated in technical terms.

> Is the IPMI watchdog different to 
> all the other watchdogs or why is it listed seperatly?
CONFIG_WATCHDOG only purpose is to disable all watchdogs living in 
drivers/char/watchdog directory, nothing more. Enabling it doesn't add any 
code unless you also add some specific watchdog.

ipmi_watchdog relies on IPMI (IPMI_HANDLER) and probably that's why it's 
listed separatly.

> Holger

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux

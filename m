Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUG1J3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUG1J3f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 05:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266847AbUG1J3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 05:29:35 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:64273 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S266845AbUG1J3c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 05:29:32 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Subject: Re: IPMI watchdog question
Date: Wed, 28 Jul 2004 11:29:22 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, minyard@acm.org
References: <Pine.LNX.4.58.0407280901330.31636@praktifix.dwd.de>
In-Reply-To: <Pine.LNX.4.58.0407280901330.31636@praktifix.dwd.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407281129.22431.arekm@pld-linux.org>
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

On Wednesday 28 of July 2004 11:08, Holger Kiehl wrote:
> Hello
>
> Using kernel 2.6.7 with ipmi watchdog compiled in, I have noticed that
> when the process writting to /dev/watchdog is killed (-9) the system is
> not reset. When I query the BMC to list the SEL it does report:
>
>    Watchdog 2 #0x03 | Timer expired
>
> So the BMC does notice that the timer did expire but no action is taken.
> What must I do so it resets my system?
Do you have CONFIG_WATCHDOG_NOWAYOUT enabled?

Also driver needs to be converted to honor nowayout module option, too.

> Thanks,
> Holger

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTHWLZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 07:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbTHWLZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 07:25:16 -0400
Received: from smtphost.cis.strath.ac.uk ([130.159.196.96]:29399 "EHLO
	smtphost.cis.strath.ac.uk") by vger.kernel.org with ESMTP
	id S262622AbTHWLZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 07:25:10 -0400
Date: Sat, 23 Aug 2003 12:24:46 +0100
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: dahinds@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0t4 - no pcmcia
Message-ID: <20030823112446.GA3341@iain-vaio-fx405>
Mail-Followup-To: dahinds@users.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 12:15:56 up 27 min,  5 users,  load average: 0.70, 0.60, 0.87
X-Message-Flag: Outlook viruses can be made to send private documents from your hard drive to any or all recipients from your address book. But it only happens about once a month or so, so it's okay. Just keep on using it.
User-Agent: Mutt/1.5.4i
X-CIS-MailScanner: Found to be clean
X-CIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-7, required 5,
	BAYES_00 -5.20, UPPERCASE_25_50 0.97, USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After booting 2.6.0-test4, i get the following error when trying to
initialise cardmgr:

orinoco_cs: RequestIRQ: Resource in use

I couldn't see anything changed in the config that could have caused
this.

$ diff linux-2.6.0-test3/.config linux-2.6.0-test4/.config
12a13
> # CONFIG_BROKEN is not set
21a23,24
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
25a29
> CONFIG_IOSCHED_NOOP=y
104c108
< # ACPI Support
---
> # ACPI (Advanced Configuration and Power Interface) Support
105a110
> # CONFIG_ACPI_HT is not set
123a129,132
> 
> #
> # APM (Advanced Power Management) BIOS Support
> #
230a240
> # CONFIG_BLK_DEV_IDETAPE is not set
471a482
> CONFIG_XFRM=y
568a580
> # CONFIG_SIS190 is not set
771a784
> # CONFIG_AGP_ATI is not set
1114a1128,1129
> # CONFIG_CRYPTO_CAST5 is not set
> # CONFIG_CRYPTO_CAST6 is not set

cheers,

iain
(back on test3 for now)
-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine

"As for compromises: no. Free or fuck off."
	-- Andrew Suffield, on debian-legal

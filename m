Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVCJCkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVCJCkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVCJCVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:21:21 -0500
Received: from taco.zianet.com ([216.234.192.159]:23300 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S261666AbVCJCRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:17:09 -0500
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with PPPD on dialup with 2.6.11-bk1 and later; 2.6.11 is OK
Date: Wed, 9 Mar 2005 19:14:24 -0700
User-Agent: KMail/1.6.1
Cc: Russell King <rmk+serial@arm.linux.org.uk>,
       Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503091914.24612.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today at 04:57:37 pm, I wrote:
>Earlier today, I reported "PPPD fails on recent 2.6.11-bk".  I've narrowed
>the problem down to between 2.6.11 and 2.6.11-bk1.
>
>I get this with 2.6.11-bk1: (two attempts)
>
>Mar  9 16:34:32 spc pppd[1142]: pppd 2.4.1 started by steven, uid 501
>Mar  9 16:34:32 spc pppd[1142]: Using interface ppp0
>Mar  9 16:34:32 spc pppd[1142]: Connect: ppp0 <--> /dev/ttyS1
>Mar  9 16:34:56 spc pppd[1142]: Hangup (SIGHUP)
>Mar  9 16:34:56 spc pppd[1142]: Modem hangup
>Mar  9 16:34:56 spc pppd[1142]: Connection terminated.
>Mar  9 16:34:56 spc pppd[1142]: Exit.

Searching lkml archive, I found:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111031501416334&w=2

I also found that reverting that patch made the problem go away for 2.6.11-bk1.

The bookmarkable link for this changeset is here:
http://linus.bkbits.net:8080/linux-2.5/cset@4228d0d83vitxwMSdjDcnjt90uXocg?nav=index.html|ChangeSet@-8w

Stephen Hemminger also wrote: (Someting's busted with serial in 2.6.11 latest)
>Some checkin since 2.6.11 has caused the serial driver to
>drop characters.  Console output is chopped and messages are garbled.
>Even the shell prompt gets truncated.

Hope this helps,
Steven


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424269AbWLHEW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424269AbWLHEW2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 23:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424315AbWLHEW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 23:22:27 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:2153 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424269AbWLHEW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 23:22:27 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <mrmacman_g4@mac.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
       <schwab@suse.de>
Subject: RE: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Date: Thu, 7 Dec 2006 20:22:17 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKCEINADAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <A1480C13-162B-4593-A378-05FE43D1D0D2@mac.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 07 Dec 2006 21:25:32 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 07 Dec 2006 21:25:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In that case it specifies that any evaluation of "*foo" in an rvalue
> context specifies a read (with a few exceptions for G++ where the C++
> language generally confuses things).  Specifically it mentions the
> statement "*src;" and discusses the statement as providing "a void
> context".  In other words, a statement such as "(void)(expr);" is
> redundant because the statement already implies void context and the
> extra cast-to-void is just extra text.  As such "(void)(*src);" on a
> "volatile int *src;" is documented to force a read of "*src".  Now,
> if you actually _use_ the result over just casting it to void and
> discarding it, then GCC can provide no _less_ guarantee with regards
> to the read-and-store than it provides to the read-and-discard.

I read over this section and didn't realize the implications of the void
context. I now agree with you.

DS



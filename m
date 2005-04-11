Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVDKCQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVDKCQb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 22:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVDKCQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 22:16:31 -0400
Received: from ciistr2.ist.utl.pt ([193.136.128.2]:53641 "EHLO
	ciistr2.ist.utl.pt") by vger.kernel.org with ESMTP id S261662AbVDKCQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 22:16:26 -0400
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Processes stuck on D state on Dual Opteron
Date: Mon, 11 Apr 2005 01:38:51 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <200504100328.53762.ctpm@rnl.ist.utl.pt> <20050409194746.69cfa230.akpm@osdl.org>
In-Reply-To: <20050409194746.69cfa230.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504110138.51872.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday 10 April 2005 03:47, Andrew Morton wrote:
>
> Suggest you boot with `nmi_watchdog=0' to prevent the nmi watchdog from
> cutting in during long sysrq traces.
>
> Also, capture the `sysrq-m' output so we can see if the thing is out of
> memory.

  Hi Andrew,

  Thanks for the tip. I booted with nmi_watchdog=0 and was able to get a full 
sysrq-t as well as a sysrq-m. Since it might be a little too big for the 
list, I've put it on a text file at:

 http://193.136.132.235/dl145/dump1-2.6.12-rc2.txt

 I also made a run with the mempool-can-fail patch from Nick Piggin. With this 
I got some nice memory allocation errors from the md threads when the trouble 
started. The dump (with sysrq-t and sysrq-m included) is at:

 http://193.136.132.235/dl145/dump2-2.6.12-rc2-nick1.txt

 Let me know if you find it more convenient to send the dumps by mail or 
something. Hope this helps.

 Thanks,

Claudio


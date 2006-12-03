Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760033AbWLCTcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760033AbWLCTcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 14:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760034AbWLCTcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 14:32:25 -0500
Received: from h155.mvista.com ([63.81.120.155]:9993 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1760033AbWLCTcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 14:32:24 -0500
Message-ID: <457326A2.2020402@ru.mvista.com>
Date: Sun, 03 Dec 2006 22:33:54 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: mingo@elte.hu
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t in	latency_trace.c
 (take 3)
References: <200611132252.58818.sshtylyov@ru.mvista.com>
In-Reply-To: <200611132252.58818.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I wrote:

> In addition to the clock jump-back check being falsely triggered by clock wrap
> with 32-bit cycles_t, as noticed by Kevin Hilman, there's another issue: using
> %Lx format to print 32-bit values warrants erroneous values on 32-bit machines
> like ARM and PPC32...

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

    What was the destiny of that patch? I haven't seen it accepted, haven't 
seen any comments... while this is not a mere warning fix. What am I expected 
to do to get it accepted -- recast it against 2.6.19-rt1?

>  kernel/latency_trace.c |   42 +++++++++++++++++++++---------------------
>  1 files changed, 21 insertions(+), 21 deletions(-)

WBR, Sergei

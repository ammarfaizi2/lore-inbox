Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVACD6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVACD6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 22:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVACD6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 22:58:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:60859 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261288AbVACD6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 22:58:38 -0500
Message-ID: <41D8C161.5000102@osdl.org>
Date: Sun, 02 Jan 2005 19:52:01 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Jim Nelson <james4765@cwazy.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Coywolf Qi Hunt <coywolf@gmail.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk loglevel policy?
References: <28707.1104722227@ocs3.ocs.com.au>
In-Reply-To: <28707.1104722227@ocs3.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Sun, 02 Jan 2005 13:41:34 -0800, 
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
>>Jim Nelson wrote:
>>
>>>Or does printk() do some tracking that I didn't see as to where in the 
>>>kernel the strings are coming from?
>>
>>That kind of garbled output has been known to happen, but
>>the <console_sem> is supposed to prevent that (along with
>>zap_locks() in kernel/printk.c).
> 
> 
> Using multiple calls to printk to print a single line has always been
> subject to the possibility of interleaving on SMP.  We just live with
> the risk.  Printing a complete line in a single call to printk is
> protected by various locks.  Print a line in multiple calls is not
> protected.  If it bothers you that much, build up the line in a local
> buffer then call printk once.

True, I was thinking about the single line case, which I
have seen garbled/mixed in the past (on SMP).  Hopefully
that one is fixed.

-- 
~Randy

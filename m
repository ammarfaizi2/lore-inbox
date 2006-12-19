Return-Path: <linux-kernel-owner+w=401wt.eu-S932556AbWLSA7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWLSA7P (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWLSA7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:59:14 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:23289 "HELO
	smtp108.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932556AbWLSA7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:59:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=1DKUx1BLM4zIk823U1yZoBKeI3rC7u1gw4kVyFKq9aGc5cCD1F75Cb3KQJ2ihP2jWwJEiefWOzMYfm8MYSxii3jOCehWBDSpt61IBNfuJK7KjkcJKAIZtITGyPA4USXigoWuZn9NQ65jmDll1h98u3H4Ph4la1PyX8PlQ2jDaeY=  ;
X-YMail-OSG: bX9iXwkVM1m_oUGR_jSXvcgY9l6J5iSVa71sXb01tXlMXOtNCLjzvTR7dStqJG5yto9FHTjcWBELJ28ZwvzQ2ov9RQj_j94WQtSRSK4nOlQSlVJVHw5uBCJfTpovVqaprx5HqCbFwMHUVzqm2Imc1.QItZFN_7A7A22VkC.J40NsKxnbUX51GOBOHSfD
From: David Brownell <david-b@pacbell.net>
To: Paul Sokolovsky <pmiscml@gmail.com>
Subject: Re: [PATCH] RTC classdev: Add sysfs support for wakeup alarm (r/w)
Date: Mon, 18 Dec 2006 16:59:11 -0800
User-Agent: KMail/1.7.1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       kernel-discuss@handhelds.org, linux-kernel@vger.kernel.org
References: <1866913935.20061217213036@gmail.com> <256202025.20061219015824@gmail.com> <200612181654.30864.david-b@pacbell.net>
In-Reply-To: <200612181654.30864.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612181659.11473.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 4:54 pm, David Brownell wrote:

> > http://handhelds.org/cgi-bin/cvsweb.cgi/linux/kernel26/drivers/rtc/rtc-sa1100.c.diff?r1=1.5&r2=1.6&f=h
> 
> That patch you applied looks right to me -- why don't you forward it
> to Alessandro as a bugfix for 2.6.20-rc2, and save me the effort?

Actually, correction:  it'd be correct if you ripped out the buggy
calls to manage the irq wake mechanism.  A later message will show
how those need to work.  (The IRQ framework will give one helpful
hint when it warns about mismatched enable/disable calls ...)

- Dave

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbRGSQxF>; Thu, 19 Jul 2001 12:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265326AbRGSQw4>; Thu, 19 Jul 2001 12:52:56 -0400
Received: from sncgw.nai.com ([161.69.248.229]:41630 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265101AbRGSQwj>;
	Thu, 19 Jul 2001 12:52:39 -0400
Message-ID: <XFMail.20010719095606.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <OF592B2674.D77BFDC0-ON85256A8C.00649982@pok.ibm.com>
Date: Thu, 19 Jul 2001 09:56:06 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Hubertus Franke <frankeh@us.ibm.com>
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency (FIX)_
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On 17-Jul-2001 Hubertus Franke wrote:
> 
> 
> This only applies only to the idle thread and it says that the idle
> thread actively monitors its need_resched flag and hence will
> instantly call schedule() at that point. Hence there won't be any
> delay either for IPI or for waiting to return from the kernel.
> 
> You might be right that the problem situation still arises, because
> the idle_thread needs to content again for the lock.
> Let me ask the otherway around, why do we HAVE to put it in ?
> And if I missed something here, we put it outside the <if> clause.

Yep, we were talking about two different if-locations :)
Anyway, it's right, using the poll idle we've to change the position of the
assignment.




- Davide


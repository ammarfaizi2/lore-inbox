Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274595AbRITSWG>; Thu, 20 Sep 2001 14:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274594AbRITSVq>; Thu, 20 Sep 2001 14:21:46 -0400
Received: from [208.129.208.52] ([208.129.208.52]:48654 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274593AbRITSVm>;
	Thu, 20 Sep 2001 14:21:42 -0400
Message-ID: <XFMail.20010920112513.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010920010502.A7960@redhat.com>
Date: Thu, 20 Sep 2001 11:25:13 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Christopher K. St. John" <cks@distributopia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Sep-2001 Benjamin LaHaise wrote:
> On Wed, Sep 19, 2001 at 11:43:57PM -0500, Christopher K. St. John wrote:
>>  Sorry, bad editing, that should be:
>> 
>>  Assume a large but bursty current of low bandwidth
>> high latency connections instead of a continuous steady
>> flood of high bandwidth low latency connections.
> 
> Isn't asynchronous io a better model for that case?

The advantage /dev/epoll has compared to aio_* and RTsig is 
1) multiple event delivery/system call
2) less user<->kernel memory moves

The concept is very similar anyway coz you basically have to initiate the
io-call and wait for an event.
The difference is how events are collected.




- Davide


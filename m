Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274622AbRITT4R>; Thu, 20 Sep 2001 15:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274563AbRITT4H>; Thu, 20 Sep 2001 15:56:07 -0400
Received: from [208.129.208.52] ([208.129.208.52]:27142 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S272723AbRITTz6>;
	Thu, 20 Sep 2001 15:55:58 -0400
Message-ID: <XFMail.20010920125858.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010920153352.A20626@redhat.com>
Date: Thu, 20 Sep 2001 12:58:58 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: "Christopher K. St. John" <cks@distributopia.com>
Cc: "Christopher K. St. John" <cks@distributopia.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Sep-2001 Benjamin LaHaise wrote:
> On Thu, Sep 20, 2001 at 11:25:13AM -0700, Davide Libenzi wrote:
>> 2) less user<->kernel memory moves
>> 
>> The concept is very similar anyway coz you basically have to initiate the
>> io-call and wait for an event.
>> The difference is how events are collected.
> 
> See the above. =)  aio also works much better as the io request helps 
> define the duration for memory pinning of any O_DIRECT or similar 
> operations that allow the hardware to act on user provided buffers.

Obviously if you hook down at lower kernel levels you can better optimize the event
notification but my design guide for the patch was to be the less intrusive
as possible.
If you look at the patch, it has a very limited changes inside linux core files
and this will make it usable/merged even if it won't be included inside the
mainstream code.




- Davide


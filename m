Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265545AbRFVWVH>; Fri, 22 Jun 2001 18:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265549AbRFVWU5>; Fri, 22 Jun 2001 18:20:57 -0400
Received: from sncgw.nai.com ([161.69.248.229]:57232 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265545AbRFVWUl>;
	Fri, 22 Jun 2001 18:20:41 -0400
Message-ID: <XFMail.20010622152354.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010622175944.A6968@gruyere.muc.suse.de>
Date: Fri, 22 Jun 2001 15:23:54 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Andi Kleen <ak@suse.de>
Subject: Re: About I/O callbacks ...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22-Jun-2001 Andi Kleen wrote:
> On Fri, Jun 22, 2001 at 08:55:00AM -0700, Davide Libenzi wrote:
>> I know about rt signals and SIGIO :) but I can't see how You can queue
>> signals :
>> 
>> current->sig->action[..]
>> 
>> The action field is an array so if more than one I/O notification is fired
>> before the SIGIO is delivered, You'll deliver only the last one.
>> Am I missing something ?
> 
> Yes. Realtime signals (>=SIGRTMIN) get queued in current->pending.

An issue with rt signal is the limited number of this resource that
will force you to have a mapping  fd ==> coroutine  but this should not be a
big problem using  hash( fd ) = fd





- Davide


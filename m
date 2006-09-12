Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWILIqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWILIqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWILIqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:46:21 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:38630 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751338AbWILIqU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:46:20 -0400
Message-ID: <45067312.7020900@aitel.hist.no>
Date: Tue, 12 Sep 2006 10:42:58 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <4505694D.5020304@garzik.org> <Pine.LNX.4.64.0609110749410.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609110749410.27779@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 11 Sep 2006, Jeff Garzik wrote:
>
>   
>> Sergei Shtylyov wrote:
>>     
>>>    It's not likely I'll be able to try it. But I'm absolutely sure that
>>> drive aborted the read commands with the sector count of 0 (i.e. 256
>>> actually). The exact model was IBM DHEA-34331.
>>>    255 sectors actually seems more safe bet.
>>>       
>> This sort of thing should be handled by quirks, depending on the controller
>> and drive.
>>     
>
> Please don't play games with peoples data-safety.
>
> It ios absolutely INCORRECT to think that "things should work as 
> documented, let's fix it up with quirks".
>   
How about a simple and harmless test?
When an IDE disk is accessed for the first time, perhaps when
the partition table is read - issue a 256-sector read and see
what happens.  If it works - fine.  If not, tag the thing as
supporting max 255 sectors.

No wrecking of file systems, and full performance for
the vast majority.

Helge Hafting


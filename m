Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWD3NLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWD3NLb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 09:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWD3NLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 09:11:31 -0400
Received: from mail.tmr.com ([64.65.253.246]:17376 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751111AbWD3NLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 09:11:30 -0400
Message-ID: <4454BA24.4070204@tmr.com>
Date: Sun, 30 Apr 2006 09:22:44 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain> <200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com> <443B873B.9040908@sw.ru>
In-Reply-To: <443B873B.9040908@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

> Bill,
>
>>> OpenVZ will have live zero downtime migration and suspend/resume 
>>> some time next month.
>>>
>> Please clarify. Currently a migration involves:
>> - stopping or suspending the instance
>> - backing up the instance and all of its data
>> - creating an environment for the instance on a new machine
>> - transporting the data to a new machine
>> - installing the instance and all data
>> - starting the instance
>
>
>> If you could just briefly cover how you do each of these steps with zero
>> downtime...
>
>
> it does exactly what you wrote with some minor steps such as 
> networking stop on source and start on destination etc.
>
> So I would detailed it like this:
> - freeze VPS

when the VM stops providing services it's down as far as I'm concerned

> - freeze networking
> - copy VPS data to destination
> - dump VPS
> - copy dump to the destination
> - restore VPS
> - unfreeze VPS

and here is where my service is available again. The server may not know 
it's been down, but the clients will.

> - kill original VPS on source
>
> Moreover, in OpenVZ live migration allows to migrate 32bit VPSs 
> between i686 and x86-64 Linux machines.

I guess you're using "zero downtime" as a marketing term rather than a 
technical term.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979


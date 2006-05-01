Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWEAM2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWEAM2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 08:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWEAM2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 08:28:33 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:64236 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S932075AbWEAM2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 08:28:32 -0400
Message-ID: <4455FEBE.9080304@sw.ru>
Date: Mon, 01 May 2006 16:27:42 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain> <200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com> <443B873B.9040908@sw.ru> <4454BA24.4070204@tmr.com>
In-Reply-To: <4454BA24.4070204@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill,

>> So I would detailed it like this:
>> - freeze VPS
> 
> when the VM stops providing services it's down as far as I'm concerned
please, note, that connections are not dropped, new connections are not 
responded with RESET and when VM is migrated all the clients are 
serviced as if nothing has happened. From client point of view there is 
only a small delay in servicing, but not a real downtime (when clients 
are rejected). Maybe due to these some of people call it zero down-time. 
Though from technical POV this is not the best term for sure. It is 
better to call it checkpointing/restore or live migration.

>> - freeze networking
>> - copy VPS data to destination
>> - dump VPS
>> - copy dump to the destination
>> - restore VPS
>> - unfreeze VPS
> 
> and here is where my service is available again. The server may not know 
> it's been down, but the clients will.
> 
>> - kill original VPS on source
>>
>> Moreover, in OpenVZ live migration allows to migrate 32bit VPSs 
>> between i686 and x86-64 Linux machines.
> 
> I guess you're using "zero downtime" as a marketing term rather than a 
> technical term.

Thanks,
Kirill

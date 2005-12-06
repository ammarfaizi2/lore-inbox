Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVLFSAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVLFSAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVLFSAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:00:45 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:25402 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964800AbVLFSAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:00:45 -0500
Message-ID: <4395D1C2.2040909@cosmosbay.com>
Date: Tue, 06 Dec 2005 19:00:34 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: David Engraf <engraf.david@netcom-sicherheitstechnik.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
References: <1133871202.3664.34.camel@tara.firmix.at>	<000201c5fa60$52bb53e0$0a016696@EW10> <p73psoaqa5u.fsf@verdi.suse.de>
In-Reply-To: <p73psoaqa5u.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> "David Engraf" <engraf.david@netcom-sicherheitstechnik.de> writes:
> 
>>times has only 10ms resolution, we need at least 1ms.
> 
> 
> It actually has jiffies resultion. Your measurements must have been
> quite off.

I beg to differ: times has a 10 ms resolution ( ie 1/USER_HZ)

times() is supposed to return clock_t expressed in USER_HZ, wich is still 100, 
regardless of the kernel HZ

I just checked sources and sys_times() do use jiffies_64_to_clock_t()

Eric

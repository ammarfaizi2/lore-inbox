Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291841AbSBNTKl>; Thu, 14 Feb 2002 14:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291842AbSBNTKe>; Thu, 14 Feb 2002 14:10:34 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:13723 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291841AbSBNTKZ>; Thu, 14 Feb 2002 14:10:25 -0500
Message-ID: <3C6C0977.7030004@reviewboard.com>
Date: Thu, 14 Feb 2002 20:01:11 +0100
From: Chris Chabot <chabotc@reviewboard.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nick Craig-Wood <ncw@axis.demon.co.uk>
CC: Harald Welte <laforge@gnumonks.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
Subject: Re: 2.4.18-pre9: iptables screwed?
In-Reply-To: <a3vjts$r7l$1@cesium.transmeta.com> <20020208094649.J26676@sunbeam.de.gnumonks.org> <20020214161225.A2867@axis.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into the same problems with 2.4.18pre9, however upgrading to 
iptables 1.2.5 fixed the problem. (there's no redhat packages for it 
yet, i did a compile of the source pkg)

	-- Chris


Nick Craig-Wood wrote:
> On Fri, Feb 08, 2002 at 09:46:49AM +0100, Harald Welte wrote:
> 
>>On Thu, Feb 07, 2002 at 08:24:28PM -0800, H. Peter Anvin wrote:
>>
>>>I get the following error with iptables on 2.4.18-pre9:
>>>
>>>sudo iptables-restore < /etc/sysconfig/iptables
>>>iptables-restore: libiptc/libip4tc.c:384: do_check: Assertion
>>>`h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
>>>Abort (core dumped)
>>>
> 
> I've noticed this too.
> 
> Specifically it is fine with 2.4.17 but broken with 2.4.18-pre7-ac2
> 
> I use the mangle table to set the TOS for a few things but it gives
> this error :-
> 
>   iptables -t mangle -A add-tos -p tcp --dport ssh -m tos --tos Minimize-Delay
> 
>   iptables: libiptc/libip4tc.c:384: do_check: Assertion `h->info.valid_hooks == (1 << 0 | 1 << 3)' failed.
> 
> 
>>Could you please tell me, what iptables version are you using? 
>>(btw: please follow-up to netfilter-devel@lists.samba.org)
>>
> 
> This is using Redhat 7.2 iptables v1.2.4 from the redhat package
> iptables-1.2.4-2.
> 
> Apologies if this info is too late but I didn't see a followup to
> lkml.
> 
> 




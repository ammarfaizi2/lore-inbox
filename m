Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263313AbUCPAan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUCPA1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:27:47 -0500
Received: from knight-linux.rlknight.com ([64.165.88.6]:6149 "EHLO
	knight-linux.rlknight.com") by vger.kernel.org with ESMTP
	id S262966AbUCPAYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:24:24 -0500
Message-ID: <405644C2.3050605@rlknight.com>
Date: Mon, 15 Mar 2004 16:05:22 -0800
From: Rick Knight <rick_knight@rlknight.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Julien Didron <jdidron@tripnotik.dyndns.org>,
       norberto+linux-kernel@bensa.ath.cx
CC: linux-kernel@vger.kernel.org
Subject: Re: How to apply -mm patch?
References: <40560571.5070504@rlknight.com> <405615E0.9080800@tripnotik.dyndns.org>
In-Reply-To: <405615E0.9080800@tripnotik.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Didron wrote:

> Hello,
>
>    Instructions can be found in the Readme file included in the sources
>    basically you should cd /usr/src/linux-2.6.4
>    then cat ../2.6.4-mm | patch -p1 (2.6.4-mm being uncompressed in 
> /usr/src, of course)
>    I had an issue with that patch, you should also patch the Makefile 
> in /usr/src/linux-2.6.4 with this
>    line 990 to 995 should be replaced with that chunk (without 
> including the numbers) :    990          $(cmd_$(1)); \
>   991          scripts/basic/fixdep $(depfile) $@ '$(subst \
>   992          $$,$$$$,$(subst ','\
>   993          '',$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
>   994          rm -f $(depfile); \
>   995          mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
>
>    cheers
>
>    Julien
>
> Richard W. Knight wrote:
>
>> I've looked everywhere but can't find any instruction on how to apply 
>> the -mm patches. I've tried "patch -p0 < 2.6.4-mm" and this seems to 
>> run without error, but the resulting source won't build. Can someone 
>> give me a quick example of how to apply the 2.6.4-mm patch to 
>> linux-2.6.4?
>>
>> In answering this message, please CC me.
>>
>> Thanks,
>> Rick Knight
>> (rick_knight@rlknight.com)
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
Thanks Julien and Norberto,

That worked.

Rick Knight
(rick@rlknight.com)


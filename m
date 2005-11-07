Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVKGOmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVKGOmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKGOmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:42:22 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:11106 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750718AbVKGOmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:42:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=EP3peI/kfPQUBrrfLAcosrlc6CDe4N1YVhRtl0WnGoGEMnNik0fJE6FeRXVuDQnOF8n9Y/qh1bInrrEt82SbPDEdyjVrWQ6VeS/peDgDMzadFvccFQDJTuzMiyJ3/5u4fQIeD6Ed4GbhnDqqn5iOjrUOxRhpTrk5UuKjqjKiXi4=
Message-ID: <436F67BF.2020708@gmail.com>
Date: Mon, 07 Nov 2005 14:42:07 +0000
From: Ram Gupta <ram.gupta5@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: negative timeout can be set up by setsockopt system call
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Nish Aravamudan <nish.aravamudan@gmail.com>
 >
 > In Ram's specific case, I think, the call path is sys_setsockopt() ->
 > sock_setsockopt() -> sock_set_timeout, which has a definition of:
 >
 > static int sock_set_timeout(long *timeo_p, char __user *optval, int 
optlen)

 >> Exactly right.

 > Ram, what is the expected behavior of negative values in the timeval?
 > And what are you seeing happen right now?
 >
 > As of 2.6.14, looks like we convert any non-zero values into jiffies
 > and store them in sk->sk_{rcv,snd}timeo...
 >
 >>  I don't see any problem from the kernel side but the application
times out immediately causing certain failures as the schedule_timeout
returns immediately in case of negative values. Shouldn't there be a
check for negative values and return error to the application so that
it can handle it.

- Show quoted text -

 > This could be, and I think is what Ram was asking about -- I've asked
 > for some clarification.
 >
 > Thanks,
 > Nish
 >

regards
Ram Gupta



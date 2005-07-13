Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVGMQZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVGMQZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 12:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVGMQXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 12:23:38 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:17594 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262694AbVGMQX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 12:23:29 -0400
Message-ID: <42D53FF6.2020200@namesys.com>
Date: Wed, 13 Jul 2005 20:23:18 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Keenan Pepper <keenanpepper@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>
Subject: Re: realtime-preempt + reiser4?
References: <42D4201A.9050303@gmail.com>	 <1121198723.10580.10.camel@mindpipe>  <42D45438.6040409@gmail.com> <1121213099.3548.39.camel@localhost.localdomain>
In-Reply-To: <1121213099.3548.39.camel@localhost.localdomain>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Steven Rostedt wrote:
> On Tue, 2005-07-12 at 19:37 -0400, Keenan Pepper wrote:
> 
> 
>>I naively changed these two calls from
>>
>>init_MUTEX_LOCKED(&name);
>>
>>to
>>
>>init_MUTEX(&name);
>>down(&name);
>>
>>but I'm not sure if that's right. I guess I'll see when I try to boot it!
> 
> 
> No, since it probably wont be "uped" by the same process.  So what you
> want to do is change the definition of name from semaphore to
> compat_semaphore, and keep it as init_MUTEX_LOCKED.  And please send
> patches to Ingo (I've included him on CC).  Also include Ingo on all RT
> related issues, since he is the one maintaining the patch.
> 

ftp://ftp.namesys.com/pub/reiser4-for-2.6/2.6.12/reiser4-for-2.6.12-realtime-preempt-2.6.12-final-V0.7.51-29.patch.gz
It applies to 2.6.12 + http://people.redhat.com/mingo/realtime-preempt/older/realtime-preempt-2.6.12-final-V0.7.51-29

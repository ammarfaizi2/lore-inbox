Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVF1OQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVF1OQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVF1OQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:16:47 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:60097 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261675AbVF1OMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:12:52 -0400
Message-ID: <42C15AA7.40508@jp.fujitsu.com>
Date: Tue, 28 Jun 2005 23:11:51 +0900
From: Naoaki Maeda <maeda.naoaki@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [ckrm-tech] [patch 25/38] CKRM e18: Add fork rate control to
 the numtasks controller
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com> <20050623061759.325157000@w-gerrit.beaverton.ibm.com> <42BFA5C6.9040604@jp.fujitsu.com> <20050627132704.GA3555@bitwizard.nl>
In-Reply-To: <20050627132704.GA3555@bitwizard.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rogier Wolff wrote:
> On Mon, Jun 27, 2005 at 04:07:50PM +0900, Naoaki Maeda wrote:
> 
>>Gerrit Huizenga wrote:>
> 
>  > +By default, the sys_total_tasks is set to 131072(128k), and forkrate is set
> 
>>>+to 1 million and forkrate_interval is set to 3600 seconds. Which means the
>>>+total number of tasks in a system is limited to 131072 and the forks are
>>>+limited to 1 million per hour.
>>
>>From the same point of view, the default value of forkrate should be
>>no limit. (In addition, 1 million tasks per hour is not an abnormally
>>high rate.)
> 
> 
> It is quite high. however, in some applications I can immagine that a
> machine would indeed trigger a very high fork rate.
> 
> For example, a machine that runs lots of shell scripts that call each
> other, may all of a sudden be forking the required 300/second....

I agree that it is quite high rate. However, as you pointed out,
shell scripts may fork processes in very high rate.

Another reason I don't like this default values is that
forkrate_interval is too long.

Please imagine if forkrate limite is reached in the first 30 minutes,
we cannot fork any process for another 30 minutes. It is not what
I expected.

Thanks,
MAEDA Naoaki



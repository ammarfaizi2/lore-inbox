Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWADHtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWADHtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 02:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWADHtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 02:49:36 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:13010 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751195AbWADHtg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 02:49:36 -0500
Message-ID: <43BB7E0A.2070304@watson.ibm.com>
Date: Wed, 04 Jan 2006 02:49:30 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 6/6] Delay accounting: Connector interface
References: <43BB05D8.6070101@watson.ibm.com> <43BB09D4.2060209@watson.ibm.com> <20060104002112.GA18730@kroah.com> <43BB19FC.9020905@watson.ibm.com> <20060104005131.GA19356@kroah.com>
In-Reply-To: <20060104005131.GA19356@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Wed, Jan 04, 2006 at 12:42:36AM +0000, Shailabh Nagar wrote:
>  
>
>>Greg KH wrote:
>>    
>>
>>>On Tue, Jan 03, 2006 at 11:33:40PM +0000, Shailabh Nagar wrote:
>>>
>>>      
>>>
>>>>Changes since 11/14/05:
>>>>
>>>>- explicit versioning of statistics data returned
>>>>- new command type for returning per-tgid stats
>>>>- for cpu running time, use tsk->sched_info.cpu_time (collected by schedstats)
>>>>
>>>>First post 11/14/05
>>>>
>>>>delayacct-connector.patch
>>>>
>>>>Creates a connector interface for getting delay and cpu statistics of tasks
>>>>during their lifetime and when they exit. The cpu stats are available only if
>>>>CONFIG_SCHEDSTATS is enabled.
>>>>        
>>>>
>>>Why do you use this when we can send typesafe data through netlink
>>>messages now?  
>>>      
>>>
>>AFAIK, adding new netlink types was frowned upon which is one of the reasons why
>>connectors were proposed (besides making it easier to use the netlink interface) ?
>>    
>>
>
>I don't know about the issue of creating new types (have you tried?),
>but there is a new netlink message format that pretty should make it
>just as easy as the connector stuff to send complex message types.
>  
>

Thanks - just saw the genetlink patches/interface which seems to handle 
the problem of
creating new netlink types as well.

But why do I get the feeling that the delay accounting patches are 
becoming a pawn in deprecating connector usage ? :-)
I'd rather not run off and implement over genetlink (which no one else 
seems to be using right now) unless there's some
consensus that connectors are to be deprecated.

Andrew - any opinions ?

-- Shailabh

>thanks,
>
>greg k-h
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
>_______________________________________________
>Lse-tech mailing list
>Lse-tech@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/lse-tech
>
>  
>



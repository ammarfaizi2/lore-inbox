Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbTISAaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 20:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTISAaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 20:30:20 -0400
Received: from anumail3.anu.edu.au ([150.203.2.43]:34196 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S262223AbTISAaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 20:30:06 -0400
Message-ID: <3F6A4E07.5040309@cyberone.com.au>
Date: Fri, 19 Sep 2003 10:29:59 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
MIME-Version: 1.0
To: "Vander Velden, Kent" <kent.vandervelden@pioneer.com>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18 Scheduler Bug?
References: <EF9FD28280A17140A3366737EB698AD50BF2B3@jhms08.phibred.com>
In-Reply-To: <EF9FD28280A17140A3366737EB698AD50BF2B3@jhms08.phibred.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not that I know of unfortunately.

Vander Velden, Kent wrote:

>Thank you for your response.  I was affraid this might be the problem.
>Is there anything that we can do now, i.e. is there a SMP kernel does
>does consider priority?
>
>  Thanks.
>
>
>  
>
>>-----Original Message-----
>>From: Nick Piggin [mailto:piggin@cyberone.com.au]
>>Sent: Wednesday, September 17, 2003 10:48 PM
>>To: Vander Velden, Kent
>>Subject: Re: Linux 2.4.18 Scheduler Bug?
>>
>>
>>
>>
>>Vander Velden, Kent wrote:
>>
>>    
>>
>>>Please CC: responses to my email.
>>>
>>>On two seperate SMP machines I run two instances of two 
>>>      
>>>
>>different programs, minimin.x and random_simplex.  Both 
>>instances of random_simplex are niced to 20 on both machines. 
>> Both minimin.xand random_simplex are CPU bound processes.  
>>On the first machine the processes are allocated CPU as would 
>>be expected (data taken from 'top'):
>>    
>>
>>>
>>>Linux cn103 2.4.18-18.8.0smp #1 SMP Wed Nov 13 23:11:20 EST 
>>>      
>>>
>>2002 i686 i686 i386 GNU/Linux
>>    
>>
>>>
>>> PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>>>
>>>25911 f459659   25   0  3452 3452  1032 R    94.3  0.1 
>>>      
>>>
>>167:13 minimin.x
>>    
>>
>>>25903 f459659   25   0  3604 3604  1072 R    93.4  0.1 
>>>      
>>>
>>168:03 minimin.x
>>    
>>
>>>26658 f493418   39  19  5396 5396  4188 R N   5.9  0.2   
>>>      
>>>
>>0:42 random_simplex
>>    
>>
>>>26682 f493418   39  19  5124 5124  4188 R N   5.9  0.1   
>>>      
>>>
>>0:42 random_simplex
>>    
>>
>>>
>>>However, on the second machine they are not:
>>>
>>>
>>>
>>>Linux cn065 2.4.18-18.8.0smp #1 SMP Wed Nov 13 23:11:20 EST 
>>>      
>>>
>>2002 i686 i686 i386 GNU/Linux
>>    
>>
>>>
>>> PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>>>
>>>26881 f459659   25   0  3452 3452  1032 R    55.6  0.1 
>>>      
>>>
>>137:03 minimin.x
>>    
>>
>>>27630 f493418   39  19  5272 5272  4188 R N  50.6  0.2   
>>>      
>>>
>>4:37 random_simplex
>>    
>>
>>>27654 f493418   39  19  5124 5124  4188 R N  50.6  0.1   
>>>      
>>>
>>4:37 random_simplex
>>    
>>
>>>26873 f459659   25   0  3564 3564  1072 R    44.7  0.1 
>>>      
>>>
>>137:19 minimin.x
>>    
>>
>>>
>>>Renicing the processes has not affect.  Restarting the 
>>>      
>>>
>>processes seems to help.  What might be
>>    
>>
>>>causing this?  Are there any know bugs in the SMP schechuler 
>>>      
>>>
>>in 2.4.18 that might cause this? 
>>    
>>
>>The scheduler does not take priority into account when doing SMP
>>balancing.
>>
>>    
>>
>>>Is there a workaround or does a more recent kernel fix this?
>>>
>>>      
>>>
>>Not as far as I know. I'm working on it in 2.6.
>>
>>
>>
>>    
>>
>
>
>This communication is for use by the intended recipient and contains 
>information that may be privileged, confidential or copyrighted under
>applicable law.  If you are not the intended recipient, you are hereby
>formally notified that any use, copying or distribution of this e-mail,
>in whole or in part, is strictly prohibited.  Please notify the sender
>by return e-mail and delete this e-mail from your system.  Unless
>explicitly and conspicuously designated as "E-Contract Intended",
>this e-mail does not constitute a contract offer, a contract amendment,
>or an acceptance of a contract offer.  This e-mail does not constitute
>a consent to the use of sender's contact information for direct marketing
>purposes or for transfers of data to third parties.
>
> Francais Deutsch Italiano  Espanol  Portugues  Japanese  Chinese  Korean
>
>            http://www.DuPont.com/corp/email_disclaimer.html
>
>
>
>
>  
>



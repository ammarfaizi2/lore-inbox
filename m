Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTBDOFs>; Tue, 4 Feb 2003 09:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTBDOFs>; Tue, 4 Feb 2003 09:05:48 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:44780 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267278AbTBDOFr>; Tue, 4 Feb 2003 09:05:47 -0500
Message-ID: <3E3FCA3F.7030105@blue-labs.org>
Date: Tue, 04 Feb 2003 09:12:15 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030131
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Gale <gale@syntax.dstl.gov.uk>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not  2.4.x,
References: <Pine.LNX.3.96.1030203155651.28323A-100000@dstl.gov.uk> <1044352722.18392.6.camel@syntax.dstl.gov.uk>
In-Reply-To: <1044352722.18392.6.camel@syntax.dstl.gov.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've run into this often with a background job however .. it also hangs 
when there isn't any background job.  I suspect there definitely is a bug.

David

Tony Gale wrote:

>On Mon, 2003-02-03 at 21:04, Bill Davidsen wrote:
>  
>
>>That is a problem with processes left running. I do not forward
>>connections, I do not forward X, I do not (in normal practice) leave
>>anything running. A typical thing to do is to go to each machine in a
>>cluster and look for a user activity:
>>  grep "user" log/stats.readers
>>  exit
>>nothing more. And every once in a while that hangs after executing the
>>logout sequence. With the patch it hasn't to date.
>>
>>That doesn't mean it's a fix, I don't see it every day, I just haven't
>>seen it in a few days since I put in the patch.
>>    
>>
>
>The ssh hang on exit "problem" is a policy of the ssh coders. It'll
>happen when you have a background job still running when you exit, which
>is still connected to the terminal.
>
>As I said, it's an ssh policy issue (which many people disagree with)
>and not a bug.
>
>-tony
>  
>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTKBMGP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 07:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTKBMGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 07:06:15 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:39987 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S261662AbTKBMGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 07:06:13 -0500
Message-ID: <3FA4F33A.7080207@planet.nl>
Date: Sun, 02 Nov 2003 13:06:18 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031025
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Di-30 non working [bug 967]
References: <3FA41703.1030408@planet.nl> <200311012228.29085.bzolnier@elka.pw.edu.pl> <20031101152453.42346338.akpm@osdl.org> <200311020054.49869.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200311020054.49869.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've done some more testing and the drive is now responding to commands 
:-) so we are getting more close. It however still fails to give the 
status back and is busy after the first command. I've included a dmesg, 
updated patch and strace as attachment to the bug report. In the dmesg I 
see a oops I hope that this will help you find the problem. I also had 
an oops at the first try but got lost during the cut and paste work :-( 
sorry for that.

Best regards,

Stef

Bartlomiej Zolnierkiewicz wrote:

>On Sunday 02 of November 2003 00:24, Andrew Morton wrote:
>  
>
>>Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>>    
>>
>>>Noticed by Stuart_Hayes@Dell.com:
>>>
>>>I've noticed that, in the 2.6 (test 9) kernel, the "cmd" field (of type
>>>int) in struct request has been removed, and it looks like all of the
>>>code in ide-tape has just had a find & replace run on it to replace any
>>>instance of rq.cmd or rq->cmd with rq.flags or rq->flags.
>>>      
>>>
>>Nasty.
>>
>>    
>>
>  
>


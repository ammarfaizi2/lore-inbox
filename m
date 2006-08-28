Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWH1MKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWH1MKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWH1MKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:10:41 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:39355 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S964819AbWH1MKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:10:40 -0400
Message-ID: <44F2DEDC.3020608@student.ltu.se>
Date: Mon, 28 Aug 2006 14:17:32 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Christoph Hellwig <hch@infradead.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
References: <44EFBEFA.2010707@student.ltu.se> <20060828093202.GC8980@infradead.org> <Pine.LNX.4.61.0608281255100.14305@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608281255100.14305@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>>Just would like to ask if you want patches for:
>>>      
>>>
>>Total NACK to any of this boolean ididocy.  I very much hope you didn't
>>get the impression you actually have a chance to get this merged.
>>
>>    
>>
>>>* (Most importent, may introduce bugs if left alone)
>>>Fixing boolean checking, ex:
>>>if (bool == FALSE)
>>>to
>>>if (!bool)
>>>      
>>>
>>this one of course makes sense, but please do it without introducing
>>any boolean type.  Getting rid of all the TRUE/FALSE defines and converting
>>all scsi drivers to classic C integer as boolean semantics would be
>>very welcome janitorial work.
>>    
>>
>
>I don't get it. You object to the 'idiocy' 
>(http://lkml.org/lkml/2006/7/27/281), but find the x==FALSE -> !x 
>a good thing?
>  
>
That is error-prone. Not "==FALSE" but what happens if x is (for some 
reason) not 1 and then "if (x==TRUE)". There has been suggestions of doing:
if (x != FALSE)
or
if (!x == !TRUE)
but a simple "if (x)" is (in my opinion) the correct way.

Then that there is some objections booleans not being the "classical 
C"-way, is another story.

>Jan Engelhardt
>  
>
Richard Knutsson

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWH1X0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWH1X0m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 19:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWH1X0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 19:26:42 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:15601 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S964883AbWH1X0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 19:26:41 -0400
Message-ID: <44F37D4C.1080801@student.ltu.se>
Date: Tue, 29 Aug 2006 01:33:32 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@austin.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 2.6.18-rc4-mm2] fs/jfs: Conversion to generic boolean
References: <44F086E8.7090602@student.ltu.se>	 <1156774979.7495.5.camel@kleikamp.austin.ibm.com>	 <44F35537.6000308@student.ltu.se> <1156799492.8732.19.camel@kleikamp.austin.ibm.com>
In-Reply-To: <1156799492.8732.19.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp wrote:

>On Mon, 2006-08-28 at 22:42 +0200, Richard Knutsson wrote:
>
>  
>
>>Just why is it, that when there is a change to make locally defined 
>>booleans into a more generic one, it is converted into integers? ;)
>>    
>>
>
>I just see this as an opportunity to make jfs more closely fit the
>coding style of the mainline kernel.
>  
>
That is what I am trying to do, making bool as accepted as any other 
integer. No more, no less.

>  
>
>>But seriously, what is gained by removing them, other then less 
>>understandable code? (Not talking about FALSE -> 0, but boolean_t -> int)
>>    
>>
>
>I don't feel strongly one way or another about the use of boolean_t, but
>under fs/, the only code that uses that type is in fs/jfs and fs/xfs,
>which are both ported from other operating systems.  Using ints for
>boolean values does seem to be the accepted practice in the kernel.
>  
>
Yes it is, but I am (for now) trying to convert those who uses some sort 
of boolean to the generic one (in fs/ for now). Right now the ntfs/- and 
partitions/-conversion seem to have thumbs up, in -mm.

>  
>
>>I can understand if authors disprove making an integer into a boolean, 
>>but here it already were booleans.
>>But hey, you are the maintainer ;)
>>    
>>
>
>I could be persuaded to leave the declarations as boolean_t or even
>making them bool, but right now I'm leaning toward making them int for
>consistency.
>  
>
A root-beer maybe?
What do you say, can you hold on it for a while (can't be urgent, can 
it?) and see how the conversion go. Will take time for it during this 
week(end) and if the result is that almost no maintainer wants it, then...
Just seem strange to having a boolean function but declaring it integer, 
for (in my knowledge) no reason.

>Shaggy
>  
>
Richard Knutsson


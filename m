Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbTJNJEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbTJNJEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:04:13 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:30696 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262285AbTJNJEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:04:09 -0400
Message-ID: <3F8BBC08.6030901@namesys.com>
Date: Tue, 14 Oct 2003 13:04:08 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wes Janzen <superchkn@sbcglobal.net>
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com
Subject: Re: Why are bad disk sectors numbered strangely, and what happens
 to them?
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net>
In-Reply-To: <3F8BA037.9000705@sbcglobal.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wes Janzen wrote:

>
>>
>>
>> You have to do the math on the LBA sector numbers (subtract the
>> partition start, divide by two).
>> Also, you can use the "badblocks" program.  
>>
> I think he's using reiserfs on the partition, which ASFAIK doesn't 
> support marking bad sectors without some work.  I tend to agree with 
> namesys when they suggest just getting a new drive if it has used up 
> all of its extra sectors.  In my experience (admittedly limited), any 
> drive which runs out of extra sectors starts to go bad in a hurry.
>
> -Wes-
>
>>             Roger.  
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
I think the problem is that many users don't know how to trigger the bad 
sector remapping for the case where the drive can still remap, using 
writes to the bad blocks, and probably our faq needs updating.

nikita, can you do that?

-- 
Hans



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbTIYOAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 10:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbTIYOAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 10:00:46 -0400
Received: from dyn-ctb-210-9-245-204.webone.com.au ([210.9.245.204]:63499 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261235AbTIYOAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 10:00:36 -0400
Message-ID: <3F72F4DC.8050708@cyberone.com.au>
Date: Thu, 25 Sep 2003 23:59:56 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
CC: "Dave Gilbert (Home)" <gilbertd@treblig.org>,
       "Norris, Brent" <bnorris@Edmonson.k12.ky.us>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 128G Limit in Reiserfs? Or the Kernel? Or something else?
References: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA86E@E151000N0> <3F72EC23.6070403@treblig.org> <20030925134314.GE32614@rdlg.net>
In-Reply-To: <20030925134314.GE32614@rdlg.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its an IDE issue. You need 48-bit addressing to access above 128GB on
IDE drives. I'm not sure exactly what the IDE guys need from you...
Post the output of dmesg, lspci, .config.

Testing the latest kernel would be an idea, if you are not running it.

Robert L. Harris wrote:

>
>I have about 2 filesystems currently at 600Gig.
>
>Reiser has no inodes so I guarantee your out but it's irrelevant.
>What does df -k actually show?  You sure you don't have a process with
>an open log file that's been removed?
>
>Thus spake Dave Gilbert (Home) (gilbertd@treblig.org):
>
>
>>Norris, Brent wrote:
>>
>>>I seem to have hit an odd limit, that I didn't think existed.  I have a 
>>>250G
>>>WD IDE hard drive that I have just installed.  Since I couldn't put a Ext3
>>>filesystem on it (mount wouldn't recognize it) I decided to put a ReiserFS
>>>filesystem on it.  Since I have done that I have added 128G of data to the
>>>drive.  Now when I attempt to copy more data to it I get an error that 
>>>there
>>>is no more space on the drive.
>>>
>>Reiser can definitly do larger file systems than that (I have a Reiser 
>>file system with over 300GB on).
>>
>>Its worth trying a df -i to make sure you haven't run out of inodes - 
>>but then you say you can create empty files.
>>
>>Dave
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>:wq!
>---------------------------------------------------------------------------
>Robert L. Harris                     | GPG Key ID: E344DA3B
>                                         @ x-hkp://pgp.mit.edu
>DISCLAIMER:
>      These are MY OPINIONS ALONE.  I speak for no-one else.
>
>Life is not a destination, it's a journey.
>  Microsoft produces 15 car pileups on the highway.
>    Don't stop traffic to stand and gawk at the tragedy.
>
>  
>


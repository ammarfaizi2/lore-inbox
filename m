Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316617AbSE0Nnw>; Mon, 27 May 2002 09:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316620AbSE0Nnv>; Mon, 27 May 2002 09:43:51 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:54535 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S316617AbSE0Nnt>; Mon, 27 May 2002 09:43:49 -0400
Message-ID: <3CF23893.207@loewe-komp.de>
Date: Mon, 27 May 2002 15:45:55 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andreas Hartmann <andihartmann@freenet.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <fa.na0lviv.e2a93a@ifi.uio.no> <actahk$6bp$1@ID-44327.news.dfncis.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann wrote:
> Zwane Mwaikambo wrote:
> 
> 
>>On Mon, 27 May 2002, Andreas Hartmann wrote:
>>
>>
>>>rsync allocates all of the memory the machine has (256 MB RAM, 128 MB
>>>swap). When this occures, processes get killed like described in the
>>>posting before. The machine doesn't respond as long as the rsync -
>>>process isn't killed, because it fetches all the memory which gets free
>>>after a process has been killed.
>>>
>>And the rsync process never gets singled out? nice!
>>
> 
> Until it's killed by the kernel (if overcommitment isn't deactivated). If 
> overcommitment is deactivated, the services of the machine are dead 
> forever. There will be nothing, which kills such a process. Or am I wrong?
> 

There is still the oom killer (Out Of Memory).
But it doesn't trigger and the machine pages "forever".
Usually kswapd eats the CPU then, discarding and reloading pages,
searching lists for pages to evict and so on.


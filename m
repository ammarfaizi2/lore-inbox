Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313468AbSDGUTV>; Sun, 7 Apr 2002 16:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313469AbSDGUTU>; Sun, 7 Apr 2002 16:19:20 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:17352 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S313468AbSDGUTT>;
	Sun, 7 Apr 2002 16:19:19 -0400
Message-ID: <3CB0A9B9.8050309@acm.org>
Date: Sun, 07 Apr 2002 15:19:05 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to open files a process has mmapped
In-Reply-To: <E16tuKm-0002Kp-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>a file a process has mmap-ed.  The trouble is that the file might be 
>>deleted (this is actually likely in this scenario) so I can't just open 
>>the file listed in /proc/<pid>/maps
>>
>Well perhaps they should not have deleted it
>
>>I have looked some at this, and I haven't come up with a good solution 
>>for this.  I have come up with the following solutions:
>>
>You forgot fix the program to do sensible things. You can pass file handles
>over AF_UNIX sockets for example, or you could rename the file so you can
>find it then delete it later
>
The customer is used to doing this on another operating system, and they 
have a system already designed that works this way.  I agree that there 
are more sensible solutions, but I have to think about this from my 
customer's point of view.  If a simple way to do this existed, it would 
save them time.

>>The last solution I could think of was to provide a way to open a file 
>>with using the major/minor/inode (since these are listed for the mapped 
>>files in the /proc/<pid>/maps file).  This is kind of ugly, but it's 
>>probably the best one I've thought of.
>>
>Nice way to do security holes
>
Obviously, this would be a root-only thing.  I don't think it opens up 
anything more than root already has, does it?  Or am I missing something?

-Corey


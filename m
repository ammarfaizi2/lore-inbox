Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310430AbSCPQmN>; Sat, 16 Mar 2002 11:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310431AbSCPQmD>; Sat, 16 Mar 2002 11:42:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25099 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310430AbSCPQlw>;
	Sat, 16 Mar 2002 11:41:52 -0500
Message-ID: <3C9375B7.3070808@mandrakesoft.com>
Date: Sat, 16 Mar 2002 11:41:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems using new Linux-2.4 bitkeeper repository.
In-Reply-To: <200203161608.g2GG8WC05423@localhost.localdomain> <3C9372BE.4000808@mandrakesoft.com> <20020316083059.A10086@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>On Sat, Mar 16, 2002 at 11:28:46AM -0500, Jeff Garzik wrote:
>
>>>Well, I tried this, but it just gave me a slew of initial rename conflicts.  
>>>
>>This is normal, you just need to accept the remote changes for all those 
>>new/renamed files.  BitKeeper doesn't support doing this automatically 
>>for all files, so I had to highlight the expected BitKeeper response in 
>>another window, and then click <paste> on my mouse around 300 times... 
>>(~300 new files)
>>
>
>Yuck.  So you knew without any doubt what it was that you wanted?  How?
>If this is a common case, I can add an option to the resolver, but it
>strikes me that there must be some other problem here.  What are those
>300 files?
>

I started with Linus's linux-2.4 repo and so did Marcelo.  We 
independently checked in 2.4.recent patches (including proper renametool 
use), which included the ia64 and mips merges, which added a ton of 
files.  When you do a 'bk pull' from Marcelo's linux-2.4 into my old 
marcelo-2.4 repo, you have to individually tell BitKeeper that you 
really do want to trust Marcelo's copy over my own, for each of the ~300 
new files that were added between Linus's linux-2.4 repo creation and 2 
days ago.  So I highlighted "rl\ny\n" in another window, and wore out my 
middle mouse button...  Renames could have been handled similarly, but 
there were few renames, so I just typed "r\ny\n" manually maybe 10 or 20 
times.

One could argue that a "rla" or "lla" command would be useful when 
resolving a conflict between two new files, telling BitKeeper to accept 
remote (or local) additions in this case _and_ all succeeding cases.

One could also argue that BitKeeper needs to be twacked on the head 
because it is not detecting that the file-creates and file-renames are 
100% the same, content-wise.

    Jeff





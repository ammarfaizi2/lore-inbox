Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311865AbSCTRZY>; Wed, 20 Mar 2002 12:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311866AbSCTRZO>; Wed, 20 Mar 2002 12:25:14 -0500
Received: from [195.63.194.11] ([195.63.194.11]:41742 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311865AbSCTRY7>; Wed, 20 Mar 2002 12:24:59 -0500
Message-ID: <3C98C594.6070402@evision-ventures.com>
Date: Wed, 20 Mar 2002 18:23:32 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: "David S. Miller" <davem@redhat.com>, pavel@suse.cz, davej@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: Bitkeeper licence issues
In-Reply-To: <20020319002241.K17410@suse.de> <20020319220631.GA1758@elf.ucw.cz> <20020319152502.J14877@work.bitmover.com> <20020319.152759.06816290.davem@redhat.com> <20020319154436.N14877@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Tue, Mar 19, 2002 at 03:27:59PM -0800, David S. Miller wrote:
> 
>>   From: Larry McVoy <lm@bitmover.com>
>>   Date: Tue, 19 Mar 2002 15:25:02 -0800
>>
>>   Come on Pavel, in order to make this happen, you have to
>>   
>>   	a) run the installer as root
>>   	b) know the next pid which will be allocated
>>   	c) put the symlink in /tmp/installer$pid
>>   
>>Exploit: Make all 65535 $pid simlinks
>>
>>It's very exploitable actually, and is similar in vein to
>>all the ancient mktemp stuff.
> 
> 
> Hey Dave, are you suggesting that no such exploits exist in Red Hat's 
> rpm system?  In order for that to be true, rpm would have to be making
> sure that each and every directory along any path that it writes is
> not writable except by priviledged users.  I just checked, it doesn't.
> 
> We can sit here all day and make a big deal out of this, I think it's a
> waste of time.  I'm not an advocate of insecure software and I'm happy
> to close any holes that people think need closing, but you're just
> wasting time.  This isn't an issue.  If you really, really cared, there
> is nothing to prevent you from downloading the BK image, unpacking it on
> a throwaway machine, back it back up again in a shar file or whatever,
> and then installing it.
> 
> At some point, people get to take responsibility for their own choices.

BTW> The proper way of using files in /tmp is not to make guessable
filenames in the cathegory /tmp/gangbang$pid!

<TECHING MODE>
Please explore the world of mkstemp() and friends on the manpages
and forget about create() or O_* for this purpose. OK?
As an added bonus you will not break export TMPDIR=~/mybed
and firends for the paranoid users.
</TECHING MODE>

This should be a reflex for someone with such a Sun heritage like you...

And finally - please don't mistake me - I don't think that this issue
is a big deal in this particular case...


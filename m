Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293029AbSCEAHV>; Mon, 4 Mar 2002 19:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293033AbSCEAHM>; Mon, 4 Mar 2002 19:07:12 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:22803 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S293029AbSCEAGy>; Mon, 4 Mar 2002 19:06:54 -0500
Message-ID: <3C838C89.5060602@namesys.com>
Date: Mon, 04 Mar 2002 18:02:33 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin> <20020304050450.GF353@matchmail.com> <20020303223103.J4188@lynx.adilger.int> <3C8308FE.FC4FA42@mandrakesoft.com> <20020303231851.N4188@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>On Mar 04, 2002  00:41 -0500, Jeff Garzik wrote:
>
>>Andreas Dilger wrote:
>>
>>>Actually, there are a whole bunch of performance issues with 1kB block
>>>ext2 filesystems.  For very small files, you are probably better off
>>>to have tails in EAs stored with the inode, or with other tails/EAs in
>>>a shared block.  We discussed this on ext2-devel a few months ago, and
>>>while the current ext2 EA design is totally unsuitable for that, it
>>>isn't impossible to fix.
>>>
>>IMO the ext2 filesystem design is on it's last legs ;-)   I tend to
>>think that a new filesystem efficiently handling these features is far
>>better than dragging ext2 kicking and screaming into the 2002's :)
>>
>
>That's why we have ext3 ;-).  Given that reiserfs just barely has an
>fsck that finally works most of the time, and they are about to re-do
>the entire filesystem for reiser-v4 in 6 months, I'd rather stick with
>glueing features onto an ext2 core than rebuilding everything from
>scratch each time.
>
Isn't this that old evolution vs. design argument?  ReiserFS is design, 
code, tweak for a while, and then start to design again methodology.  We 
take novel designs and algorithms, and stick with them until they are 
stable production code, and then we go back and do more novel 
algorithms.  Such a methodology is well suited for doing deep rewrites 
at 5 year intervals.  

No pain, no gain, or so we think.  Rewriting the core is hard work.   
Some people get success and then coast.  Some people get success and 
then accelerate.  We're keeping the pedal on the metal.  We're throwing 
every penny we make into rebuilding the foundation of our filesystem.  

ReiserFS V3 is pretty stable right now.   Fsck is usually the last thing 
to stabilize for a filesystem, and we were no exception to that rule.

ReiserFS V3 will last for probably another 3 years (though it will 
remain supported for I imagine at least a decade, maybe more), with V4 
gradually edging it out of the market as V4 gets more and more stable. 
 During at least the next year we will keep some staff adding minor 
tweaks to V3.  For instance, our layout policies will improve over the 
next few months, journal relocation is about to move from Linux 2.5 to 
2.4, and data write ordering code is being developed by Chris.  I don't 
know how long fsck maintenance for V3 will continue, but it will be at 
least as long as users find bugs in it.  

The biggest reason we are writing V4 from scratch is that it is a thing 
of beauty.  If you don't understand this, words will not explain it.  

>
>
>Given that ext3, and htree, and all of the other ext2 'hacks' seem to
>do very well, I think it will continue to improve for some time to come.
>A wise man once said "I'm not dead yet".
>
>Cheers, Andreas
>--
>Andreas Dilger
>http://sourceforge.net/projects/ext2resize/
>http://www-mddsp.enel.ucalgary.ca/People/adilger/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>




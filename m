Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314145AbSDFLDQ>; Sat, 6 Apr 2002 06:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314157AbSDFLDP>; Sat, 6 Apr 2002 06:03:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:42500 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S314145AbSDFLDP>; Sat, 6 Apr 2002 06:03:15 -0500
Message-ID: <3CAEE365.4020301@namesys.com>
Date: Sat, 06 Apr 2002 16:00:37 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org,
        flx <flx@namesys.com>
Subject: Re: ReiserFS Bug Fixes 3 of 6 (Please apply all 6)
In-Reply-To: <200204052027.g35KRc002869@bitshadow.namesys.com> <Pine.LNX.4.33.0204051347500.1746-100000@penguin.transmeta.com> <20020405171001.C6087@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am confused, the bk patches look like they have normal patches at the 
top of them.  Does he just need to use patch -p1 or is there a deeper 
screwiness to these patches that he refers to?

We did this because my security/sysadmin specialist (flx) is not 
enthusiastic about having a semi-closed source network service offering 
process running on the machine which holds our source code and website 
without any IP filters guarding it.  Especially when it is as 
complicated as a version control system needs to be.

We were planning on setting up a clone for non-Namesys users outside our 
firewall, but we need for Linus's access to be just as secure as ours. 
 I am not sure what to do, let's see what flx says.

Hans

PS for Larry (Persons not interested in licensing issues should not read 
further)

Keeping source code secret is the worst part of the proprietary model. 
 It prevents knowledge from accumulating, and it is an abuse of the 
original intention of copyright law, which was to encourage people to 
not keep knowledge secret.  I know that piracy has caused you to keep 
the source code secret, but piracy is a problem for all software (even 
GPL software, as proprietary software vendors frequently steal it). 
 Please don't let a few bad experiences lead you down the trade secret 
route that copyright and patent laws were designed to let us escape from.

Secret source code is a form of social lockout, and avoiding that 
lockout is the civil rights issue of our day.  This will only become 
more and more important in the coming generations, as our shadows in 
cyberspace become more solid, and firmer in their replication of our 
evils.  Lockout of programs, and of persons who modify programs, is 
going to be the most important civil rights issue of your lifetime.  Are 
you sure you are standing where you want to stand on that issue?

Another model you might consider, one which would probably make you more 
money, make us happier, and better avoid "freeloaders", would be to make 
bitkeeper free for use with free software only.  This would be rather 
similar to what I use for reiserfs, which is free for use with free 
operating systems only, and available for a fee for all others.  It 
allows you to "do unto others as they would do unto you" (The Reiser 
Rule ;-) ).

Hans



Larry McVoy wrote:

>On Fri, Apr 05, 2002 at 01:48:30PM -0800, Linus Torvalds wrote:
>
>>On Sat, 6 Apr 2002, Hans Reiser wrote:
>>
>>>This changeset is to fix several reiserfs problems which can be
>>>fixed in non-intrusive way.
>>>
>>Please don't use bk patches, they have turned out to be pretty much 
>>unusable.
>>
>
>I suspect that the problem is that BK won't let you accept a patch unless
>the receiving repository has the parent of the patch.  In other words,
>this won't work:
>
>	bk clone bk://linux.bkbits.net/linux-2.5
>	<make some changes>
>	bk commit (or bk citool)	# creates changeset 1.800
>	<make some changes>
>	bk commit (or bk citool)	# creates changeset 1.801
>
>	# Now you want to send the second patch to Linus so you do a:
>	bk send -r+ - | mail linux-kernel@vger.kernel.org
>
>That will fail when Linus tries to accept the patch, because he doesn't
>have your 1.800.
>
>The easiest thing is to do what he suggests:
>
>>Either make a (controlled) bk tree available for pulling, or just use 
>>old-fashioned patches.
>>
>
>and if you want to go the "tree for pulling", you can either point him at
>a BK url you maintain, or you are welcome to go grab resierfs.bkbits.net
>and stash it there.  See http://www.bitkeeper.com/Hosted.html for information
>on how to set up a project here.
>
>At some point, we'll package up the whole bkbits.net infrastructure as an
>installable RPM (not the project data, the infrastructure), and you'll be
>able to do this at resierfs.bkbits.kernel.org or something like that, but
>right now we're just too overworked to do so.
>




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282862AbRK0ID2>; Tue, 27 Nov 2001 03:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282861AbRK0IDQ>; Tue, 27 Nov 2001 03:03:16 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:50412 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S282855AbRK0ICf>; Tue, 27 Nov 2001 03:02:35 -0500
Message-ID: <3C034889.6040000@oracle.com>
Date: Tue, 27 Nov 2001 03:02:17 -0500
From: Svein Erik Brostigen <svein.brostigen@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Gregory Maxwell <greg@linuxpower.cx>
CC: "H. Peter Anvin" <hpa@zytor.com>, David Weinehall <tao@acc.umu.se>,
        linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net> <Pine.LNX.4.21.0111261351160.13786-100000@freak.distro.conectiva> <9tu0n2$sav$1@cesium.transmeta.com> <20011126192902.M5770@khan.acc.umu.se> <3C028A8D.8040503@zytor.com> <20011126161802.A8398@xi.linuxpower.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:

>On Mon, Nov 26, 2001 at 10:31:41AM -0800, H. Peter Anvin wrote:
>
>>Consistency is a Very Good Thing[TM] (says the one who tries to teach
>>scripts to understand the naming.)  The advantage with the -rc naming is
>>that it avoids the -pre5, -pre6, -pre-final, -pre-final-really,
>>-pre-final-really-i-mean-it-this-time phenomenon when the release
>>candidate wasn't quite worthy, you just go -rc1, -rc2, -rc3.  There is no
>>shame in needing more than one release candidate.
>>
>
>Why not just disguard this sillyness of alphabetic characters in version
>numbers... Just carry through the same structure used by major/minor:
>I.e.
>
>2.0.39 < released 2.0.39
>2.0.39.1.1 < first development snapshot of the kernel which will eventually
>	     be 2.0.40
>2.0.39.1.2 < second
>2.0.39.1.n < Nth
>2.0.39.2.1 < first RC
>2.0.39.2.2 < second RC
>2.0.39.3.1 < opps! Development went too long and we had to break feature
>	     freeze to add important features.
>2.0.39.4.1 < Trying to stablize again
>2.0.39.4.2 < a few more bugs fixxed
>2.0.40	   < Looks like 2.0.39.4.2 got it right!
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
What really scares me is not so much the way the kernels are numbered as 
the way features gets added to
the kernels.
Internally in Oracle we do not add new features to a release number, 
just bug-fixes.
Hence 2.4.0 is the base release of the 2.4.x kernel series. the minor 
x-number should just indicate a bug-fix
release. Thus, no new features should get added to the 2.4 kernel with 
this numbering schema.
If you really want to add features into the 2.4.x kernel, you also need 
to extend the numbering schema.
I.e 2.4.0.x wil then be the bug-fix releases and  2.4.1.x will have new 
features.
This makes it easier to maintain and to understand what is happening 
between the various releases.

As far as I can understand, today, new features are added to a released 
kernel without any sensible numbering scheme
identifying this fact. I don't know if a 2.4.10 kernel contains the same 
features as 2.4.16 with the only difference beeing bug-fixes
or if there have been added new features. By using a numbering scheme 
that is consistent across both development and
production kernels, it is easier to identify the features in a kernel.

I realize that this is a lot easier to do when you are using a source 
code repository than by hand administration.
I think the time has come for the kernel to find it's way into a cvs 
form. It has to be done, sooner or later, why not now when the 2.5
kernel has been forked?

And I do agree with people who has asked for a bug system to identify 
the various bugs and their fixes.

I have been looking forward to the 2.5 kernel because I have wanted to 
get involved in the kernel devlopment, but have not
wanted to jump in on an existing production/development kernel. The most 
confusing part today is all the various patches
beeing sendt around on the lkml. A lot of people who wants to develop, 
do not have the time to keep on top of the
mailing list. We do have other jobs too, that pays for our food and 
clothes. This is done on our spare time and having
to spend a few hours every day, reading through the kernel list and 
applying various patches seems like a waste
of time. Unless a different system is devised, I think I will stay away 
from the kernel development and
concentrate on other things.

I'm sorry if this seems like a flame-bait, it was not intended to be and 
I did not intend to offend anyone either. My apologies to
anyone who feels so.

-- 
Regards
Svein Erik

I've given up reading books; I find it takes my mind off myself.
_____________________________________________________________
Svein Erik Brostigen       e-mail: svein.brostigen@oracle.com
Senior Technical Analyst                  Phone: 407.458.7168
EBC - Extended Business Critical
Oracle Support Services
5955 T.G. Lee Blvd
Orlando FL, 32822

Enabling the Information Age Through Internet Computing
_____________________________________________________________

The statements and opinions expressed here are my own and
do not necessarily represent those of Oracle Corporation.




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129571AbRBVXXW>; Thu, 22 Feb 2001 18:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130512AbRBVXXM>; Thu, 22 Feb 2001 18:23:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:22033 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129571AbRBVXXB>; Thu, 22 Feb 2001 18:23:01 -0500
Message-ID: <3A959F35.A99CEEEC@transmeta.com>
Date: Thu, 22 Feb 2001 15:22:29 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Bill Crawford <billc@netcomuk.co.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
In-Reply-To: <3A959BFD.B18F833@netcomuk.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Crawford wrote:
> 
>  A particular reason for this, apart from filesystem efficiency,
> is to make it easier for people to find things, as it is usually
> easier to spot what you want amongst a hundred things than among
> a thousand or ten thousand.
> 
>  A couple of practical examples from work here at Netcom UK (now
> Ebone :), would be say DNS zone files or user authentication data.
> We use Solaris and NFS a lot, too, so large directories are a bad
> thing in general for us, so we tend to subdivide things using a
> very simple scheme: taking the first letter and then sometimes
> the second letter or a pair of letters from the filename.  This
> actually works extremely well in practice, and as mentioned above
> provides some positive side-effects.
> 

This is sometimes feasible, but sometimes it is a hack with painful
consequences in the form of software incompatibilites.

>  I guess what I really mean is that I think Linus' strategy of
> generally optimizing for the "usual case" is a good thing.  It
> is actually quite annoying in general to have that many files in
> a single directory (think \winnt\... here).  So maybe it would
> be better to focus on the normal situation of, say, a few hundred
> files in a directory rather than thousands ...

Linus' strategy is to not let optimizations for uncommon cases inflict
the common case.  However, I think we can make an improvement here that
will work well even on moderate-sized directories.

My main problem with the fixed-depth tree proposal is that is seems to
work well for a certain range of directory sizes, but the range seems a
bit arbitrary.  The case of very small directories is also quite
important, too.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

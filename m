Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSJUV52>; Mon, 21 Oct 2002 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261717AbSJUV52>; Mon, 21 Oct 2002 17:57:28 -0400
Received: from ns.suse.de ([213.95.15.193]:8718 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261661AbSJUV51> convert rfc822-to-8bit;
	Mon, 21 Oct 2002 17:57:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Subject: Re: [PATCH][RFC] 2.5.42 (1/2): Filesystem capabilities kernel patch
Date: Tue, 22 Oct 2002 00:03:32 +0200
User-Agent: KMail/1.4.3
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
References: <87y98vmuqf.fsf@goat.bogus.local> <200210200224.07867.agruen@suse.de> <87fzuzke5m.fsf@goat.bogus.local>
In-Reply-To: <87fzuzke5m.fsf@goat.bogus.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210220003.32601.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I believe that Capabilities on the file system are a useful thing. They 
obviously also are quite controversial. If deployed without the right tools 
they may certainly lead to less secure systems. So these supporting tools 
need to be develped first, and some real-world experience seems necessary to 
learn more.

Whatever the result of this process will be, should we decide to have 
filesystem capabilities we would need to associate some pieces of information 
with individual inodes, and this is exactly what Extended Attributes were 
designed for. There are implementations for ext2, ext3, jfs, xfs, reiserfs, 
so I think it makes no sense to reinvent the wheel. (Xattrs (or EAs) were 
actually not invented for Linux; Irix and other OSes support almost identical 
schemes.)

Do you happen to know the attr(5) manual page? An online version is available 
at <http://acl.bestbits.at/cgi-man/attr.5>; perhaps that helps.

--Andreas.

On Monday 21 October 2002 17:25, Olaf Dietsche wrote:
> Andreas Gruenbacher <agruen@suse.de> writes:
> > Capabilities should be implemented as extended attributes;
>
> Why "should" this be implemented as extended attributes? What are the
> benefits in doing so?
>
> > see Ted's recent postings.
>
> Ted's recent postings argue against capabilities at all. So what do
> you mean?
>
> Regards, Olaf.


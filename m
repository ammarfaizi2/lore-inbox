Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSEYOSR>; Sat, 25 May 2002 10:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314637AbSEYOSQ>; Sat, 25 May 2002 10:18:16 -0400
Received: from ivimey.org ([194.106.52.201]:62023 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S314634AbSEYOSP>;
	Sat, 25 May 2002 10:18:15 -0400
Date: Sat, 25 May 2002 15:18:00 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Jeremy White <jwhite@codeweavers.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: isofs unhide option:  troubles with Wine
In-Reply-To: <1022301029.2443.28.camel@jwhiteh>
Message-ID: <Pine.LNX.4.44.0205251513280.10327-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 May 2002, Jeremy White wrote:

>Greetings,
>
>When installing Microsoft Office with Wine, we find that some
>MS CDs have certain files marked as hidden on the CD.

>Unfortunately, I don't have a strong feeling for what the
>'right' solution is.  I see several options:
>
>    1.  Invert the logic of the option, make it 'hide' instead
>        of unhide, and so unhide is the default.

I don't see the point of this...

>    2.  Make it possible to set this mount option from user
>        space (I don't like this, but it would get me around
>        the problem).

?? do you mean use of -oremount ?  possible, I suppose. Doesn't seem much 
better than (1) to me though.

>    3.  Make it so that isofs/dir.c still strips out hidden
>        files, but enable isofs/namei.c to return a hidden file that
>        is opened directly by name.

Yes. Do this, or something like it.

AFAIK, Windows "hidden" files are supposed to behave much like Unix 'dot' 
files (.login, etc), so IMO the kernel should not use the hidden bit at all. 
Instead, it should be 'ls' et al that do this. Now, I guess this isn't 
particularly practical without changing fileutils and many other things, so I 
would suggest that the kernel is changed to pass on, if possible, but 
basically ignore the 'hidden' bit.

Regards,

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.


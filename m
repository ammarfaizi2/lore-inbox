Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUBCTdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUBCTbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:31:46 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:27667 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S266116AbUBCTba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:31:30 -0500
Message-ID: <401FF70F.30203@zvala.cz>
Date: Tue, 03 Feb 2004 20:31:27 +0100
From: Tomas Zvala <tomas@zvala.cz>
User-Agent: Mozilla Thunderbird 0.5a (20031223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Martin_Povoln=FD?= <xpovolny@aurora.fi.muni.cz>
CC: John Bradford <john@grabjohn.com>, M?ns Rullg?rd <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz> <Pine.LNX.4.53.0402031018170.31411@chaos> <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk> <yw1xsmhsf882.fsf@kth.se> <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk> <20040203174606.GG3967@aurora.fi.muni.cz>
In-Reply-To: <20040203174606.GG3967@aurora.fi.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Povolný wrote:

>>>>I.E.
>>>>
>>>>mount disc
>>>>view contents
>>>>unmount disc
>>>>erase disc - but don't erase the CD-R drive's cache of the media
>>>>mount disc
>>>>view old contents of the media from the CD-R drive's cache
>>>>        
>>>>
>
>That's it exactly.
>  
>
So after all my (s)wag was correct :)

So I took a quick look through ATAPI specification (I have to say I'm a 
user not a developer) and found nothing that would seem to flush that 
damn cache. So the problem is that some CD-R drives (probably the older 
ones) expect you to eject CD after burning (even a buffer/cache clearing 
after burn would seem logical to me) and there is nothing you can do 
about it (except buying different drive). Unfortunately it is not a 
kernel or cdrecord issue (if it was it could have been fixed:) ). I 
guess you'll just have to do with ejecting :). Sorry.


Tomas Zvala

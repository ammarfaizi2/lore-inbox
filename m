Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279790AbRKAVji>; Thu, 1 Nov 2001 16:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279800AbRKAVj3>; Thu, 1 Nov 2001 16:39:29 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:27609 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S279790AbRKAVjT>; Thu, 1 Nov 2001 16:39:19 -0500
Message-ID: <3BE1C07D.5080205@antefacto.com>
Date: Thu, 01 Nov 2001 21:37:01 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: writing a plugin for reiserfs compression
In-Reply-To: <Pine.LNX.4.30.0111012218420.3201-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:

>>>I just thought there was a patch doing windows nt-like
>>>compress-em-all-realtime-and-get-doomed!
>>>
>>I don't know what the actual heuristics for determining which files are
>>compression with the ext2 patch.  It is definitely NOT a compressed
>>block device.  Files are compressed in chunks (32kB?), so that it is
>>possible to seek and do read-modify-write (e.g. appending to a file)
>>without decompressing the entire file and/or recompressing it.  This also
>>protects against block corruption, since you would limit the amount of
>>data lost to the end of the chunk after the bad spot.


It's a compilation option to never compress gz files. I guess it would
be easy to add others (bz2, Z, jpg, mp3, ...) to the list?. The max
chunk used for compression is 32KB and again this is configurable, as
is the compression method/level used. The alogorithms are gzip (1-9),
LZO, bz2.


>>
> 
> But still... Are the files are compressed as they are created/modified on
> the filesystem?


Only if the file is in a directory with the +c attribute set.
You can have full control over the compression.

Note this transparent ext2 compression patch is only available for 2.2

Padraig.


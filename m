Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131126AbRARLxg>; Thu, 18 Jan 2001 06:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132495AbRARLx1>; Thu, 18 Jan 2001 06:53:27 -0500
Received: from mirasta.antefacto.net ([193.120.245.10]:52996 "EHLO
	nt1.antefacto.com") by vger.kernel.org with ESMTP
	id <S131126AbRARLxL>; Thu, 18 Jan 2001 06:53:11 -0500
Message-ID: <3A66D93C.8090500@AnteFacto.com>
Date: Thu, 18 Jan 2001 11:53:32 +0000
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: dmeyer@dmeyer.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Documenting stat(2)
In-Reply-To: <20010118020528.A16871@jhereg.dmeyer.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmeyer@dmeyer.net wrote:

> In article <9463fj$gsq$1@penguin.transmeta.com> you write:
> 
>> Basically, the _only_ think you should depend on is that st_size
>> contains:
>>  - for regular files, the size of the file in bytes
>>  - for symlinks, the length of the symlink.
> 
> I don't think this is right - for a symlink, stat should return the
> size of the file; lstat should return the size of the symlink.

Nope stat should return the details of the symlink
whereas lstat should return the details of the symlink target.

But there is another ambiguity when stating symlinks.
In the current implementation the length of the symlink (name)
is the same as the symlink file size. Will this always
be the case? If not then the above statement is wrong.
i.e.

 >> - for symlinks, the length of the symlink.

should be

 >> - for symlinks, the symlink file size in bytes (currently the
 >>   length of the symlink).

Padraig.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

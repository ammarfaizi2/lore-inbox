Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315568AbSENJ2u>; Tue, 14 May 2002 05:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315570AbSENJ2t>; Tue, 14 May 2002 05:28:49 -0400
Received: from [195.137.26.28] ([195.137.26.28]:52945 "EHLO
	shami.gointernet.co.uk") by vger.kernel.org with ESMTP
	id <S315568AbSENJ2s>; Tue, 14 May 2002 05:28:48 -0400
Message-ID: <3CE0D8C4.50509@gointernet.co.uk>
Date: Tue, 14 May 2002 10:28:36 +0100
From: Eugenio Mastroviti <eugeniom@gointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs has killed my root FS!?!
In-Reply-To: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm> <Pine.GSO.4.21.0205121838230.27629-100000@weyl.math.psu.edu> <20020512225623.GG1020@louise.pinerecords.com> <3CDF1F1B.1090302@mindspring.com> <20020513104615.A10664@namesys.com> <3CDFE8DC.1090803@gointernet.co.uk> <20020513230500.A1897@namesys.com> <3CE0CDC8.1080000@gointernet.co.uk> <20020514130153.A817@namesys.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

> First of all make sure that your raid array same up fully.
> This is very important! Check all the partitions if they are of correct size.

Already done. I booted with the rescue system from the installation CD 
and I rewrote /etc/raidtab. The partition table seems OK, the partitions 
  have the correct sizes and the correct types.
The raid array starts fine and /proc/mdstat reports everything OK


> Then do rebild-sb and choose more correct superblock version (if asked).
> If you are not asked for the fs version, that's bad. Let us know then.

Just done that.
It's asked me the fs type and I've entered the one you told me. It 
seemed to work. I ran --rebuild-tree after that and it started replaying 
the journal - which it had not done before - but then it still died with 
"wrong superblock". The exact message is:

init_source_bitmap: bitmap 0 (of 6450048 bits) is wrong - make all 
blocks [0-32768] as used

init_control_bitmap: wrong super block

I guess I made things worse with my initial attempt as rebuilding the 
superblock.

BTW - I tried, as I have nothing to lose at this point :) - to re-do 
--rebuild-sb and now it doesn't ask for the version

> Thanks for your report.

Thanks very much for your help

Eugenio




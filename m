Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTJQOxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 10:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTJQOxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 10:53:24 -0400
Received: from zeke.inet.com ([199.171.211.198]:2996 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S263478AbTJQOxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 10:53:22 -0400
Message-ID: <3F90025A.7070504@inet.com>
Date: Fri, 17 Oct 2003 09:53:14 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <3F8ECA3E.4030208@draigBrady.com> <20031016231235.GB29279@pegasys.ws> <200310170803.h9H83ahx000164@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>What might be worth considering is internal NUL detection.
>>Build the block-of-zeros detection into the filesystem
>>write resulting in automatic creation of sparse files.
>>This could even work with extent based filesystems where
>>using hashes to identify shared blocks would not.
> 
> 
> Another idea could be writing uncompressed data to the disk, and
> background-compressing it with something like bzip2, but keeping the
> uncompressed data on disk as well, only over-writing it when disk
> space is low, and then overwriting the least recently used files
> first.
> 
> The upshot of all that would be that if you needed space, it would be
> there, (just overwrite the uncompressed versions of files), but until
> you do, you can access the uncompressed data quickly.
> 
> You could even take it one step further, and compress files with gzip
> by default, and re-compress them with bzip2 after long periods of
> inactivity.

Note that a file compressed with bzip2 is not necessarily smaller than 
the same file compressed with gzip.  (It can be quite a bit larger in fact.)

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------


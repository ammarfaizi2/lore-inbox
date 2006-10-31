Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422791AbWJaGbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbWJaGbw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbWJaGbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:31:52 -0500
Received: from alnrmhc13.comcast.net ([206.18.177.53]:27647 "EHLO
	alnrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1422791AbWJaGbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:31:51 -0500
Message-ID: <4546EDD4.70904@comcast.net>
Date: Tue, 31 Oct 2006 01:31:48 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Suspend to disk:  do we HAVE to use swap?
References: <4546C637.5080504@comcast.net> <200610310716.40181.rjw@sisk.pl>
In-Reply-To: <200610310716.40181.rjw@sisk.pl>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Rafael J. Wysocki wrote:
> On Tuesday, 31 October 2006 04:42, John Richard Moser wrote:
>> Something dumb came into my head, and the question is thus brought up
>> here:  Do we HAVE to use swap for suspend to disk? How about the file
>> system?
> 
> In short, we could use regular files for the suspend in the same way in which we
> use them for swap.  Namely, we could bmap() a file and create a map of it
> (eg. with extents) that would be used for accessing the corresponding disk
> sectors at the block device level.  Then, to be able to read the image the
> resume code would have to be provided with the number of the sector in which
> the suspend image header is located.
> 
> However, we already have code that allows us to use swap files for the suspend
> and turning a regular file into a swap file is as easy as running 'mkswap' and
> 'swapon' on it.

And the kernel can survive being loaded, mounting a file system
readonly, activating swapon on the swap file on the read-only file
system, and then resuming from it?

Also, the file system is consistent after a suspend to disk?

I believe I mentioned something about compressing the image as well...
> 
> Greetings,
> Rafael
> 
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRUbt0gs1xW0HCTEFAQL4nA/+JA7j+FHtmXYl2w/RpN/mZ+EMam++ippS
ildPeg/EsjdFLrc2SjmsteaPfCGokbLdA6WHwa5Uq+JB1Itu4rBLPRzvhVftm01V
XcYfInILhRNCGeGujF4P/NMFQBOPjPl1UqC+H/yehsVtj0I73ZMRDrdtI62+KWGL
ekaGKHb5rC3D0mdFOg/7ycplFbTLJii5Szn2KeHjd6+88LKbySLKv9SMPe6bMPPb
rzmy9+dzy3X/mMnWckxKyf6jFYkOXsI0GeNe/gb6Ylnpr6qNPJCPrY3MLSFKHPOA
Z7jBdS3w+glQhO0dUcsDSd9waPeOZNWGoJbq1FJIOMUiOU7fkoHVH7CNGGT+MccH
Qb8QxGhZUec77LmBAEKzpTi4R40QlHJaNHVip0NtOrTTupg+3J7SfDcDZ9frCRWa
hAs0/0sZV8y3ADtCf2bEOijj7zeLWRwSjTkj4fhXqcxlhEk030mKroYkohBGPIli
oVxRZq7nG4nY+dgNAxDCzFkyOEP5ObVq6dy7JPHfGOdPjy3gJy8cL/Y/6HxvzZIj
apHJznqz5+Bi7hFjG80++n7AzsM3RYzdWAh2OlcDM/jgZu7BypsGZ9QMkqTj6eDk
/Q11y+aj5+x4iYL2r+YrYlkhS3TIi2SUud05e8f87Di6nXiJfKLoFq6D6enU3v9M
xJ5l88pMfkQ=
=fs+p
-----END PGP SIGNATURE-----

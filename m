Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWAQTmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWAQTmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWAQTmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:42:08 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:64445 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932419AbWAQTmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:42:07 -0500
Message-ID: <43CD485F.7070208@comcast.net>
Date: Tue, 17 Jan 2006 14:41:19 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Huge pages and small pages. . .
References: <43CD3CE4.3090300@comcast.net> <20060117190650.GC13708@holomorphy.com>
In-Reply-To: <20060117190650.GC13708@holomorphy.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



William Lee Irwin III wrote:
> On Tue, Jan 17, 2006 at 01:52:20PM -0500, John Richard Moser wrote:
> 
>>Is there anything in the kernel that shifts the physical pages for 1024
>>physically allocated and contiguous virtual pages together physically
>>and remaps them as one huge page?  This would probably work well for the
>>low end of the heap, until someone figures out a way to tell the system
>>to free intermittent pages in a big mapping (if the heap has an
>>allocation up high, it can have huge, unused areas that are allocated).
>> It may possibly work for disk cache as well, albeit I can't say for
>>sure if it's common to have a 4 meg contiguous section of program data
>>loaded.
>>Shifting odd huge allocations around would be neat to, re:
>>{2m}[4M  ]{2m}  ->  [4M  ][4M  ]
> 
> 
> I've got bugs and feature work written by others that has sat on hold
> for ages to merge, so I won't be looking to experiment myself.
> 
> Do write things yourself and send in the resulting patches, though.
> 

A simple "no" would have sufficed; I was trying to find out if it's
there already.
> 
> -- wli
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDzUhdhDd4aOud5P8RAhqGAJsFBLK7791jWZE3nvA8YZXX7L5PtQCfZGdj
mo5CQcA55RPZCfZrBTOq3AI=
=bqFO
-----END PGP SIGNATURE-----

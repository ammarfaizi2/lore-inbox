Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTKNHjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 02:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTKNHjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 02:39:54 -0500
Received: from percy.comedia.it ([212.97.59.71]:63902 "EHLO percy.comedia.it")
	by vger.kernel.org with ESMTP id S262190AbTKNHjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 02:39:41 -0500
Date: Fri, 14 Nov 2003 08:39:41 +0100
From: Luca Berra <bluca@comedia.it>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
Message-ID: <20031114073940.GC25371@percy.comedia.it>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 02:11:15PM +1100, Neil Brown wrote:
> 3/ define minor numbers of block-major-9 that are larger than 255 to
>   have 6 bits of partitioning information. i.e.
>     9,0 -> md0
>     9,1 -> md1
>      ...
>     9,255 -> md255
>     9,256 -> md256
>     9,257 -> md256p1
>     9,257 -> md256p2
>      ...
>     9,320 -> md257
>     9,321 -> md257p1
>      ...
>   This has least impact on other system and is in some ways simplest,
>   but it has the problem of lack of uniformity.  You wouldn't be able
>   to partition md0, but that isn't a big problem as long as you can
>   partition some md arrays.

may i write in hex, i feel much unconfortable having 20bit numbers in
decimal?
9,0x00000 -> md0
...
9,0x000FF -> md255
9,0x00100 -> md0p1
9,0x00200 -> md0p2
...
one would expect it to be the other way around, but it is still fairly
intuitive, and it keeps uniformity.
Uniformity is important, because we can doo binary ops on the minor
number and get consistent results.

L.

-- 
Luca Berra -- bluca@comedia.it
        Communication Media & Services S.r.l.
 /"\
 \ /     ASCII RIBBON CAMPAIGN
  X        AGAINST HTML MAIL
 / \

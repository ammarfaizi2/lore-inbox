Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291414AbSBMJTx>; Wed, 13 Feb 2002 04:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291441AbSBMJTm>; Wed, 13 Feb 2002 04:19:42 -0500
Received: from hera.cwi.nl ([192.16.191.8]:36533 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S291414AbSBMJT3>;
	Wed, 13 Feb 2002 04:19:29 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 13 Feb 2002 09:18:39 GMT
Message-Id: <UTC200202130918.JAA3212400.aeb@cwi.nl>
To: davidsen@tmr.com, jgarzik@mandrakesoft.com
Subject: Re: [patch] sys_sync livelock fix
Cc: akpm@zip.com.au, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yow, your message inspired me to re-read SuSv2 and indeed confirm,

As a side note, these days you should be reading SuSv3,
it is an official standard now. See, for example,

http://www.UNIX-systems.org/version3/
http://www.opengroup.org/onlinepubs/007904975/toc.htm

> sync(2) schedules I/O but can return before completion

Don't forget that this standard does not describe what is
desirable, but describes the minimum guaranteed by all
Unices considered.

Having a sync that returns without having written the data
is not especially useful. Also without the sync this data
would have been written sooner or later.
We changed sync to wait, long ago, because otherwise shutdown
would cause filesystem corruption.

Andries

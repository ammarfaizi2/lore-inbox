Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVCURfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVCURfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 12:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVCURfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 12:35:38 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:60689 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S261215AbVCURfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 12:35:31 -0500
Message-ID: <423EEEC2.9060102@lougher.demon.co.uk>
Date: Mon, 21 Mar 2005 15:56:50 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz>
In-Reply-To: <20050321101441.GA23456@elf.ucw.cz>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>Also, this filesystem seems to do the same thing as cramfs.  We'd need to
>>>understand in some detail what advantages squashfs has over cramfs to
>>>justify merging it.  Again, that is something which is appropriate to the
>>>changelog for patch 1/1.
>>
>>Well, probably Phillip can answer this better than me, but the main 
>>differences that affect end users (and that is why we are using SquashFS 
>>right now) are:
>>                          CRAMFS          SquashFS
>>
>>Max File Size               16Mb               4Gb
>>Max Filesystem Size        256Mb              4Gb?
> 
> 
> So we are replacing severely-limited cramfs with also-limited
> squashfs... 

I think that's rather unfair, Squashfs is significantly better than 
cramfs.  The main aim of Squashfs has been to achieve the best 
compression (using zlib of course) of any filesystem under Linux - which 
it does, while also being the fastest.  Moving beyond the 4Gb limit has 
been a goal, but it has been a secondary goal.  For most applications 
4Gb compressed (this equates to 8Gb or more of uncompressed data in most 
usual cases) is ok.

> For live DVDs etc 4Gb filesystem size limit will hurt for
> sure, and 4Gb file size limit will hurt, too. Can those be fixed?

Almost everything can be fixed given enough time and money. 
Unfortunately for Squashfs, I don't have much of either.  I'm not paid 
to work on Squashfs and so it has to be done in my free time. I'm hoping 
to get greater than 4Gb support this year, it all depends on how much 
free time I get.

Phillip

> 								Pavel


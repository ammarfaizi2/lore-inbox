Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVF2B32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVF2B32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVF2B0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:26:19 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:37525 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S262307AbVF2Aju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:39:50 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Mike Bell <kernel@mikebell.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Tue, 28 Jun 2005 17:39:16 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
In-Reply-To: <20050629001243.GD4673@mikebell.org>
Message-ID: <Pine.LNX.4.62.0506281737340.24459@qynat.qvtvafvgr.pbz>
References: <20050625234305.GA11282@kroah.com> <20050627071907.GA5433@mikebell.org>
 <200506271735.50565.dtor_core@ameritech.net> <20050627232559.GA7690@mikebell.org>
 <20050628074015.GA3577@kroah.com> <20050628090852.GA966@mikebell.org>
 <1119950487.3175.21.camel@laptopd505.fenrus.org> <20050628214929.GB23980@voodoo>
 <20050628222318.GC4673@mikebell.org> <20050628234310.GA29653@mail>
 <20050629001243.GD4673@mikebell.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005, Mike Bell wrote:

> On Tue, Jun 28, 2005 at 07:43:10PM -0400, Jim Crilly wrote:
>> Well it looks like the ALSA library already abstracts the device node
>> enough that the app itself doesn't know what file is being used because it
>> just calls snd_card_get_name, snd_open_pcm, etc with the ALSA index. So
>> wouldn't it be feasible to make ALSA a little bit smarter so that it could
>> track/find the device nodes no matter what name they have?
>
> You could in theory do that to ALSA. Except for the aforementioned
> "how?". How is ALSA supposed to find out what its new device node name
> is? You could invent some sort of crazy libudev, but I think it would
> require a major redesign of how udev works, forcing it to keep state or
> such. The only alternatives I can see are what I already mentioned,
> searching every single device node in /dev to find the right one.
>
> Which is why I conclude (and, evidently, Greg agrees) that consistent
> naming schemes for /dev are very important. Now if I could just find out
> why devfs's failure to allow such broken configurations is a bug in his
> mind. :)

worse yet, go way back in the archives and you will find that prior to 
being merged into the kernel devfs supported two nameing schemes, the one 
you see now and a compatability version that matched the standard /dev 
names. one requirement for allowing it to be merged was to remove the 
compatability set of names.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

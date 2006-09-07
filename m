Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWIGJgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWIGJgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWIGJgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:36:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:26066 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751212AbWIGJfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:35:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ARsXObci9++lobuxTlrRQxVxGIG3+BbZewIrYpOIOIO0p91LG5xZNoAnp2CNJtKgZaH8qAIV46HhBZnC41QtR3ZwBuPQh37WKd1SYSOkjS9Oozdu3Mt8KmBpOM51N41uJ0CPTgXYDEf3VNfNAzJV+IzEJqQoyvkv43uSjhe3olg=
Message-ID: <6bffcb0e0609070235v6309595fgecb1880eb3185841@mail.gmail.com>
Date: Thu, 7 Sep 2006 11:35:50 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc6 00/10] Kernel memory leak detector 0.10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0609070210p661a2cd6k5683d0956aaab5fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060906223536.21550.55411.stgit@localhost.localdomain>
	 <6bffcb0e0609061710t3519e42dl6138cadd5ff0d3fb@mail.gmail.com>
	 <b0943d9e0609070104v1b747f79v3b10238954f389cd@mail.gmail.com>
	 <6bffcb0e0609070135i314f2740if067eeab342f29a2@mail.gmail.com>
	 <b0943d9e0609070137g5384b6dcp1ecff948661cd98@mail.gmail.com>
	 <6bffcb0e0609070140lb8dbee7pbedc0b38dc5a68b1@mail.gmail.com>
	 <b0943d9e0609070152v59c60eev3bbad18cd6d01dad@mail.gmail.com>
	 <6bffcb0e0609070205i27c19d3cq9fa0fc6961f28fa3@mail.gmail.com>
	 <b0943d9e0609070210p661a2cd6k5683d0956aaab5fe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 07/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > On 07/09/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > > Have you tried 16?
> >
> > No, I haven't.

With DEBUG_MEMLEAK_HASH_BITS=16 system woks fine.

>
> 8 hash bits would lead to a really slow hash table lookup since you
> would only have 256 entries and it uses linked lists to deal with
> collisions (you may have tens of thousands of pointers to be stored in
> the hash). Anyway, I attach a patch which allows you to set small
> values but it is highly unrecommended.

How about documeting maxial "safe" values?

Something like
"If you have X MB/GB of RAM memory you can set Y
X   | Y
256 MB | 25
512 MB | 26
1GB | 27
2GB | 28
4GB | 29"

>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)

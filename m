Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVGGNcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVGGNcB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVGGN3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:29:44 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:49839 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261441AbVGGN2k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:28:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KLPQ2bBf+dOvrB3OUb78hEFRqkWpXL++4uXE8TMq9Yl2LXmS231cAX3F486EoGZjYpldmslDZZ9qOR/1MESIiLP9B0zmjxux9Dbasrm19xoO8maGfSfKU95HY3MALe8eVizBcTXW3pWD9Drb9i0G9X2EdGfLjsoWqe8KOpEyYCM=
Message-ID: <84144f02050707062846365ea9@mail.gmail.com>
Date: Thu, 7 Jul 2005 16:28:39 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Head parking (was: IBM HDAPS things are looking up)
Cc: Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050707114415.GA24401@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050704063741.GC1444@suse.de> <20050704072231.GG1444@suse.de>
	 <1120462037.3174.25.camel@laptopd505.fenrus.org>
	 <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com>
	 <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de>
	 <42CCEAA7.1010807@grimmer.com>
	 <84144f02050707020765f81c38@mail.gmail.com>
	 <20050707114415.GA24401@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/05, Jens Axboe <axboe@suse.de> wrote:
> Did it say 'head parked'? If the drive is idle, you wont hear anything.
> Laptop drives auto-park really quickly themselves. A time ./park
> /dev/hda should tell you whether it needed to park or not, if it
> executes faster than a few hundred ms it was already parked.

Aah, you're right.

haji tmp # time ./a.out /dev/hda
head parked

real    0m0.421s
user    0m0.000s
sys     0m0.001s

Immediately after that:

haji tmp # time ./a.out /dev/hda
head parked

real    0m0.001s
user    0m0.000s
sys     0m0.001s

And then I do bit of disk reads and I get this again:

haji tmp # time ./a.out /dev/hda
head parked

real    0m0.429s
user    0m0.001s
sys     0m0.001s

So looks like it works for me too.

                                Pekka

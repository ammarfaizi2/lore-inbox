Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRKVJv4>; Thu, 22 Nov 2001 04:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275126AbRKVJvq>; Thu, 22 Nov 2001 04:51:46 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:28437 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S273622AbRKVJvg> convert rfc822-to-8bit; Thu, 22 Nov 2001 04:51:36 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: "H. Peter Anvin" <hpa@zytor.com>, war <war@starband.net>
Subject: Re: Swap vs No Swap.
Date: Thu, 22 Nov 2001 10:50:45 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <3BFC8D81.E25238D1@starband.net> <3BFC8DE8.7040202@zytor.com>
In-Reply-To: <3BFC8DE8.7040202@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <E166qVo-0001Bv-00@mrvdom03.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yeah, but when the disk starts swapping the system slows down to a halt.
> No, when the disk starts *THRASHING* the system slows down to a halt.
> If you are thrashing with swap you would be thrashing much worse without
> swap.

Not neccessarily. 
Your swap early swap often paradigma works fine...as long as the swap 
partition resides on an standalone harddisk without a data partition.

But imagine the situation that you have a higher band width streaming 
application - e.g. viewing a video file.  On the same hard disc there is a 
swap partition. Cache is getting bigger and bigger until kernel starts to 
swap.
Now the swapping algorithm writes on the harddisc. That troubles the  hard 
disc elevation mechanism, so  that higher bandwidth readings starve, due to 
head movements away from the data partitions towards the swap partition.

greetings

Christian Bornträger

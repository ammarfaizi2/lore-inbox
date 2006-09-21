Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWIUVWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWIUVWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWIUVWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:22:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:56164 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751578AbWIUVWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:22:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pXuvWUcC0J9QiXdsk/KpDqmHpzf+RSxrscmSWMgZf2MZ1NLkX90OtWHcsYM9tWz/ZhQEr6s1+eFSlW3egY7aQNmzYehymkfrx9lqiz4tBfzVgD8I9qW/Tk2hi5kW/jcQFF8CKTgXELJgxNCUc2HTa8Qk6OTq5xk0nsJgcmL/tnA=
Message-ID: <f4527be0609211422h5d01b22akc43ecd97110ba036@mail.gmail.com>
Date: Thu, 21 Sep 2006 22:22:53 +0100
From: "Andrew Lyon" <andrew.lyon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SOLVED: Re: JMicron 20360/20363 AHCI Controller much slower with 2.6.18
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Lyon wrote:
> > Hi,
> >
> > I have a Gigabyte GA_965P_DS3 with Core 2 Duo CPU, wd raptor connected
> > to onboard JMicron 20360/20363 AHCI Controller, with 2.6.18 the drive
> > is very slow:
> >
> > beast ~ # uname -a
> > Linux beast 2.6.18 #1 SMP Wed Sep 20 15:04:24 BST 2006 i686 Intel(R)
> > Core(TM)2 C
> > PU          6600  @ 2.40GHz GNU/Linux
> > beast ~ # hdparm -t /dev/sda
> >
> > /dev/sda:
> > Timing buffered disk reads:  100 MB in  3.02 seconds =  33.10 MB/sec
>
> Which IO scheduler are you using?  If you're using anticipatory or cfq,
> can you try deadline?
>
> Thanks.
>
> --
> tejun

Very strange, I rebooted into deadline scheduler kernel, the drive
performed as fast as with 2.6.17, due to a different problem I had to
do a hard reset and the box booted back into 2.6.18 with anticipatory
scheduler, but this time the dirve performed fine!

I had initially upgraded the kernel remotely and had only done
shutdown now -r, not a hard reset, Is it generally advisable to do a
hard reset when upgrading the kernel? (ive never read that) Is there
any way to do that remotely?

One last question, I recently got a sata dvd writer for this box as
the pata ports on the jmicron were not supported, I notice there is
now support for them in 2.6.18 (with generic ide), but which would be
best supported ? the sata dvdrw or the pata? I currently have both
available and neither is installed.

Thanks
Andy

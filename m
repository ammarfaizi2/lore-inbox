Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWIQMWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWIQMWu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 08:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWIQMWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 08:22:50 -0400
Received: from charon.hkfree.org ([212.71.131.229]:45275 "EHLO
	charon.hkfree.org") by vger.kernel.org with ESMTP id S932296AbWIQMWt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 08:22:49 -0400
From: Martin Kourim <martink@hkfree.org>
Subject: Re: sluggish system with 2.6.17 and dm-crypt - PARTLY SOLVED
Date: Sun, 17 Sep 2006 14:22:44 +0200
User-Agent: KMail/1.9.3
References: <200609161053.20317.martink@hkfree.org>
In-Reply-To: <200609161053.20317.martink@hkfree.org>
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200609171422.46629.martink@hkfree.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yesterday, I've send mail below to this list. Today I've noticed that on 
2.6.17, kjournald is running with nice level -5. On 2.6.16, kjournald is 
running with nice level 0. I did "renice 0 `pgrep kjournald`" and it 
have "solved" my problem.

I wonder why have been changed the nice level of kjournald in 2.6.17 kernel?

Thanks,
Martin Kourim

(please CC me)

Dne sobota 16 zברם 2006 10:53 jste napsal(a):
> Hi,
>
> I've got this problem with linux 2.6.17 and dm-crypt.
>
> I've got 320GB PATA hdd with one partition with dm-crypt and ext3. I've set
> it up with cryptsetup.
> When I copy some data to this encrypted partition, system is very sluggish.
> It freezes for about half a second every about 10-15 seconds.
> This problem appears only when copying data to that encrypted partition.
> There is no problem copying data to other unencrypted partitions or from
> encrypted partition.
>
> I've thought that maybe it is problem with just Debian kernels (tried
> linux-image-2.6.17-2-vserver-k7_2.6.17-8 and
> linux-image-2.6.17-2-k7_2.6.17-8), but I've got the same problem with
> vanilla 2.6.17.13.
> But... there is no problem with linux v2.6.16 (compiled from Debian
> sources).
>
> I've tried different io schedulers too (cfq, anticipatory and deadline)
> with no difference.
>
> This system is AthlonXP 2600+, 1gb ram, 2x SATA hdd and 2x PATA hdd, mb
> asus A7N8X-E deluxe.
>
> What other information should I provide?
>
> Thanks,
> Martin Kourim
>
> (please CC me)

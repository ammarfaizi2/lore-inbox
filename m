Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbUKIHkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbUKIHkx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 02:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUKIHkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 02:40:52 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:38988 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261402AbUKIHkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 02:40:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZOSsAp+m5NRjj8iSVnTgnKysryzvZ+wtg7nKjGbCeS0kMjPTq3d4j8UGnbUEOWXJwZsYIFrLNSD0yBAKSgS2i4UW3kX3doxxx6+SZaoU5NePmm6f0z6XhaA1Wbcsvx7lWj28GZRZ96Qm932R75r5iIMJuDWCipO15zva6XEREeI=
Message-ID: <84144f02041108234050d0f56d@mail.gmail.com>
Date: Tue, 9 Nov 2004 09:40:47 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Christian Kujau <evil@g-house.de>
Subject: Re: Oops in 2.6.10-rc1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>
In-Reply-To: <41901DF0.8040302@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4180F026.9090302@g-house.de>
	 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org>
	 <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de>
	 <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
	 <418F6E33.8080808@g-house.de>
	 <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>
	 <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de>
	 <41901DF0.8040302@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 09 Nov 2004 02:31:28 +0100, Christian Kujau <evil@g-house.de> wrote:
> the config is the same config i am usually using, never gave me a
> headache, new options (due to new kernel version) were left to default in
> most cases. anyway - i've pulled again a recent tree, did
> "bk undo -a1.2463" again but this time i stripped down my .config (via
> menuconfig) to the absolute necessary things:
> 
> http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/config-2.6.10-rc1_a1.2463_take2
> 
> ...and  it did *NOT* oops:
> 
> http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-no-oops-2.6.10-rc1_a1.2463.txt
> 
> i'll investigate further, building former -bk snapshots, using other
> configs before i'll fiddle around with bk again (to get the smaller
> changes). but this is a tomorrow thing, real life calls in :(

CONFIG_PREEMPT is one obvious candidate (you have that enabled in the
original config and disabled in the non-oopsing one).

                       Pekka

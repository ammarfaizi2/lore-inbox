Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVGHRTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVGHRTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVGHRTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:19:16 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:13469 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262721AbVGHRTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:19:15 -0400
Message-ID: <42CEB58E.5030401@brturbo.com.br>
Date: Fri, 08 Jul 2005 14:19:10 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Jeremy Laine <jeremy.laine@polytechnique.org>,
       linux-kernel@vger.kernel.org,
       "v4l >> Linux and Kernel Video" <video4linux-list@redhat.com>
Subject: Re: OOPS: frequent crashes with bttv in 2.6.X series (inc. 2.6.12)
References: <4nrlt-8po-15@gated-at.bofh.it> <4nrlt-8po-13@gated-at.bofh.it> <E1DqYg4-0001fC-VN@be1.7eggert.dyndns.org>
In-Reply-To: <E1DqYg4-0001fC-VN@be1.7eggert.dyndns.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> 
> 
>>Now I've upgraded to X.org 6.8.2 and done a first stress-test (copying
>>large files from network to local HDD), and I still can post.
> 
> 
> It occured again. So it wasn't that easy.

Bodo/Jeremy/Castet,

	It looks to be an old reported trouble with bttv cards.

	There is a doc at kernel that treats this subject. It is at:
		Documentation/video4linux/bttv/README.freeze


	Overlay works by transfering data from BTTV card directelly to Video Card.

	This looks to be problem related to DMA troubles on some motherboards.
Some chipsets (via being most prominent) have problems with DMA
transfers between two PCI cards (or PCI to AGP) that affects overlay. It
may also be related with multiple devices using DMA at the same time.

	Castet did mention, on this thread, that this is causing also disk
corruption on his machine, with is an inication that this is the case.

	Anyway, it doesn't seem to be a V4L specific issue.

Mauro.

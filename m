Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRCNOkG>; Wed, 14 Mar 2001 09:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131400AbRCNOj4>; Wed, 14 Mar 2001 09:39:56 -0500
Received: from windsormachine.com ([206.48.122.28]:17418 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S131386AbRCNOjh>; Wed, 14 Mar 2001 09:39:37 -0500
Message-ID: <3AAF8274.735F0F04@windsormachine.com>
Date: Wed, 14 Mar 2001 09:38:44 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Baretta <alex@baretta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 5Mb missing...
In-Reply-To: <Pine.LNX.4.33.0103070958110.1424-100000@mikeg.weiden.de> <3AAF7AD1.D24E526C@baretta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c - (http://www.inflex.co.za/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Baretta wrote:

> [alex@localhost /home]$ free -m
>              total       used       free     shared    buffers
> cached
> Mem:           251        209         42         60
> 61         92
>
> I strongly doubt this can be a bug in the kernel. Could anyone
> explain to me why this might happen?

grep Memory /var/log/kern.log

You've got your kernel itself loading into ram, reserved memory, etc.

I've got 48 meg in this test box of mine, and a free -m shows 46, a free shows
47356.  Divided by 1024, gives 46, when rounded off.  So yes, free -m is
correct.  That 251 meg is what's available to use, after your kernel loads,
etc.

mike


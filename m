Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbTBUBae>; Thu, 20 Feb 2003 20:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbTBUBae>; Thu, 20 Feb 2003 20:30:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42504 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265894AbTBUBac>;
	Thu, 20 Feb 2003 20:30:32 -0500
Message-ID: <3E55837D.5010607@pobox.com>
Date: Thu, 20 Feb 2003 20:40:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
CC: "David S. Miller" <davem@redhat.com>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com, ak@suse.de
Subject: Re: ioctl32 consolidation
References: <5.1.0.14.2.20030220145240.0d449118@mail1.qualcomm.com> <20030220223119.GA18545@elf.ucw.cz> <5.1.0.14.2.20030220145240.0d449118@mail1.qualcomm.com> <5.1.0.14.2.20030220172624.0d4c5070@mail1.qualcomm.com>
In-Reply-To: <5.1.0.14.2.20030220172624.0d4c5070@mail1.qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Krasnyansky wrote:
> Hmm. It seems to that all you need for SIOCDEVPRIVATE is ability to register
> ranges of ioctls. 
> i.e. something like this
>         int register_ioctl32_conversion_rage(uint start, uint end, handler);
> 
> net/core/dev.c
>         register_ioctl32_conversion_range(SIOCDEVPRIVATE, SIOCDEVPRIVATE + 15, siocdevprivate_ioctl);
> 
> Am I missing something here ?


Yes.  Think about the name of the ioctl :)

It is impossible for generic arch code to implement support for 
driver-private ioctls, because these naturally differ between each driver.

	Jeff




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310561AbSCLLpm>; Tue, 12 Mar 2002 06:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310602AbSCLLpd>; Tue, 12 Mar 2002 06:45:33 -0500
Received: from [195.63.194.11] ([195.63.194.11]:14344 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310561AbSCLLpY>; Tue, 12 Mar 2002 06:45:24 -0500
Message-ID: <3C8DEA0A.6050509@evision-ventures.com>
Date: Tue, 12 Mar 2002 12:44:10 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: "J. Dow" <jdow@earthlink.net>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111944090.18649-100000@penguin.transmeta.com> <3C8D8376.8010907@mandrakesoft.com> <01eb01c1c98e$e26b8200$1125a8c0@wednesday>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Dow wrote:
> From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
> 
>>Your proposal sounds 100% ok to me...
>>
>>For the details of the userspace interface (for both ATA and SCSI), my 
>>idea was to use standard read(2) and write(2).
>>
>>Any number of programs can open /dev/ata/hda/control or 
>>/dev/scsi/sdc/control.  write(2) submits requests, read(2) consumes 
>>command responses, perhaps buffering a bit so that multiple responses 
>>are not lost if userspace is slow.
>>
>>Maybe it's a cheesy way to avoid ioctl(2), maybe not...
>>
> 
> Jeff, from a security aspect would it perhaps be better to have the
> filter always in place and load rule sets through a rigidly controlled
> interface? 

You are overdesigning by a broad margin. From a security
point of view (I mean the paranoid one) the whole raw interface whatever
filtered or not should *just not be there*.


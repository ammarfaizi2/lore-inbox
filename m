Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291308AbSBXVM2>; Sun, 24 Feb 2002 16:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291318AbSBXVMS>; Sun, 24 Feb 2002 16:12:18 -0500
Received: from [195.63.194.11] ([195.63.194.11]:9747 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S291308AbSBXVMG>;
	Sun, 24 Feb 2002 16:12:06 -0500
Message-ID: <3C7956EC.5000706@evision-ventures.com>
Date: Sun, 24 Feb 2002 22:11:08 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Troy Benjegerdes <hozer@drgw.net>, Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <E16f5z8-0002id-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>The previous code didn't distinguish the bus speed between different
>>busses and it doesn't do now as well.
>>It could be really helpfull to look at the patch actually. Don't you
>>think?
>>
> 
> I know what would actually help here, (the other code wasn't broken IMHO)
> and would clean this up properly for not just IDE. Add a bus_speed field
> to the struct pci_bus - that is where the info belongs and its the platform
> specific bus code that can find the bus speed out (if anyone)

Alan you are of course right. But what to do about VLB and friends?
Unfortunately there isn't something comparable to struct pci_bus for
them in the kernel. (Or I'm missing something here?).
Iff then I would rather like to have a generic solution.

(Do you remmeber about 4 years ago there *was* already a lengthy
discussion about bus speed detection, without any proper resolution at
all...I remember myself having even provided some code for this
purpose...which was basicually just measuring RAM transfer rates...)


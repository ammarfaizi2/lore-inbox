Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288510AbSAHW25>; Tue, 8 Jan 2002 17:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288511AbSAHW2r>; Tue, 8 Jan 2002 17:28:47 -0500
Received: from tourian.nerim.net ([62.4.16.79]:57098 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S288510AbSAHW2o>;
	Tue, 8 Jan 2002 17:28:44 -0500
Message-ID: <3C3B711D.1050400@free.fr>
Date: Tue, 08 Jan 2002 23:22:21 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020105
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jussi Laako <jussi.laako@kolumbus.fi>,
        linux kernel <linux-kernel@vger.kernel.org>
Cc: Daniela Engert <dani@ngrt.de>, Andre Hedrick <hedrick@kernel.org>
Subject: Re: IDE Patch SIS ATA100
In-Reply-To: <Pine.LNX.4.10.10201080709060.991-100000@master.linux-ide.org> <3C3B6526.44A03F39@kolumbus.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:

> Andre Hedrick wrote:
> 
>>Thanks for the feedback, but lkml needs it or it will not be adopted.
>>I know the driver is stable and effectively perfect in operations.
>>So I do not understand the total ignore I receive about it.
>>
> 
> Just to avoid overperfectness... ;))
> 
> Has anyone succeeded in fixing the sis5513 driver to work with ATA100 chips?
> I get heavy disk corruption with SiS730S chipset mobo (ASUS A7S-VM).
> 
> 
> Best regards,
> 
> 	- Jussi Laako
> 
> 

I'm on it. Had some intermittent successes and thought to have a correct 
patch until today (one 2002 week with ATA100)...
But I had a bugreport today and same dma problems on my machine after a 
BIOS flashing and a new drive in the system.
Currently in heavy debugging.

PB: chip seems to init itself correctly on extended periods of time on 
my config! Makes testing rather difficult :-(

For example, with the *exact* same code this evening I had:
- a system freeze just after /sbin/init load,
- a crash after ext3 fs errors before init,
- a somewhat working boot (some weird library errors caused "ip" to not 
work),
- a fully functionnal system (no error reported, some file copies, 
reboot with ide=nodma, e2fsck -f -> no error).

If you have a system you can test on without fear of breaking things 
I'll send you patches as soon as they'll work again on my config.
Better if you want to proof-read the code :
http://gyver.homeip.net/sis5513/index.html

LB.


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312375AbSDXQLG>; Wed, 24 Apr 2002 12:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312379AbSDXQLF>; Wed, 24 Apr 2002 12:11:05 -0400
Received: from [195.63.194.11] ([195.63.194.11]:21011 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312375AbSDXQLE>; Wed, 24 Apr 2002 12:11:04 -0400
Message-ID: <3CC6CA73.2050800@evision-ventures.com>
Date: Wed, 24 Apr 2002 17:08:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Sebastian Droege <sebastian.droege@gmx.de>
CC: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [2.5.9/2.5.10] ide-scsi oops
In-Reply-To: <20020424180121.59bddc43.sebastian.droege@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Sebastian Droege napisa?:
> Hi,
> I get this nice oops every time I mount a cdrom... the cdrom drive is accessed via ide-scsi (NOT ide-cd)
> If you need more informations just ask...


No thanks it's the same problem as with ide-cd and any other drivers -
the ide_start_dma() function is expecting an strcut ata_request and not just
a simple struct request. And then there are multiple possible abuses
of the special member of struct request pracitced currently...


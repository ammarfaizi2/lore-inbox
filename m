Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314352AbSDRNsI>; Thu, 18 Apr 2002 09:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314354AbSDRNsH>; Thu, 18 Apr 2002 09:48:07 -0400
Received: from [195.63.194.11] ([195.63.194.11]:2834 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314352AbSDRNsG>;
	Thu, 18 Apr 2002 09:48:06 -0400
Message-ID: <3CBEC001.4070003@evision-ventures.com>
Date: Thu, 18 Apr 2002 14:45:53 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <20020417132852.4cf20276.sebastian.droege@gmx.de> <3CBD519F.7080207@evision-ventures.com> <20020418141746.2df4a948.sebastian.droege@gmx.de> <3CBEABEF.1030009@evision-ventures.com> <20020418125757.GF2492@suse.de> <3CBEB51F.90105@evision-ventures.com> <20020418130743.GH2492@suse.de> <3CBEB754.6010205@evision-ventures.com> <20020418131248.GI2492@suse.de> <3CBEB909.7000306@evision-ventures.com> <20020418132650.GJ2492@suse.de> <3CBEBEC2.1070304@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:

> Either way it's ide-floppy doing the abuse then :-(.
> I think the best sollution to this is anyway just to remove
> the struct packet_command altogeter and just add the required fields
> to struct ata_request - makes ata_request bigger but provides much less
> pointer tossing as a benefit.

I just did it. Advantage is: DMA works again. However on one
of the two read paths in ide-cd (FS vers block read) I get
irq underruns. This should be now fixable...



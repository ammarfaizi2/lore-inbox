Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319042AbSIJGPy>; Tue, 10 Sep 2002 02:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319044AbSIJGPy>; Tue, 10 Sep 2002 02:15:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22741 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319042AbSIJGPx>;
	Tue, 10 Sep 2002 02:15:53 -0400
Date: Tue, 10 Sep 2002 08:20:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020910062030.GL8719@suse.de>
References: <E17odbY-000BHv-00@f1.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17odbY-000BHv-00@f1.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10 2002, Samium Gromoff wrote:
>       Hello folks, i`m looking at the DAC960 driver and i have
> realised its implemented at the block layer, bypassing SCSI.
> 
>    So given i have some motivation to have a working 2.5 DAC960
> driver (i have one, being my only controller)
> i`m kinda pondering the matter.
> 
>    Questions:
>        1. Whether we need the thing to be ported to SCSI
> layer, as opposed to leaving it being a generic block device? (i suppose yes)

No

>        2. Which 2.5 SCSI driver should i use as a start of learning?

Don't bother

>        3. Whether the SCSI driver API would change during 2.5?

Possibly

The DAC960 mainly needs updating to the pci dma api, and to be adjusted
for the bio changes. Please coordinate with Daniel Philips (and check
the list archives, we had a talk about this very driver some weeks ago),
since he's working on making it work in 2.5 again as well.

-- 
Jens Axboe


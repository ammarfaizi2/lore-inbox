Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275139AbSITGPe>; Fri, 20 Sep 2002 02:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275156AbSITGPe>; Fri, 20 Sep 2002 02:15:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57563 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S275139AbSITGPd>;
	Fri, 20 Sep 2002 02:15:33 -0400
Date: Fri, 20 Sep 2002 08:20:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Dave Olien <dmo@osdl.org>
Cc: Daniel Phillips <phillips@arcor.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020920062013.GD3990@suse.de>
References: <E17odbY-000BHv-00@f1.mail.ru> <20020915131920.GR935@suse.de> <20020916131359.A17880@acpi.pdx.osdl.net> <E17r2Rr-0001Vk-00@starship> <20020919142505.B27767@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020919142505.B27767@acpi.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19 2002, Dave Olien wrote:
> 
> Daniel
> 
> Here's my latest progress on my changes to the DAC960 driver.
> 
> I spent Tuesday banging my head trying to figure out why data blocks
> written to disk to SOMETIMES were read back with DIFFERENT data.
> On wednesday, I changed from using Linux 2.5.34 to using Linux 2.5.36.
> My bad data problem went away with that change.  There must have been
> an important change in the 2.5.36 BIO code.

Neither 2.5.35 nor 2.5.36 has any critical bio fixes, so I would look
into this a bit more if I were you. Only if you were using
bio_kmap_irq() would there be something to look for, but DAC960 is not.
That was 2.5.35. 2.5.36 just starts sizing bio_vec pools based on free
memory, no bug fixes. Likewise in the block layer, I'm not seeing
anything.

-- 
Jens Axboe


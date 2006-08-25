Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422691AbWHYRHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWHYRHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWHYRHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:07:08 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:17842 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1030208AbWHYRHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:07:06 -0400
Date: Fri, 25 Aug 2006 10:07:05 -0700
From: Marc Singer <elf@buici.com>
To: Jan Bernatik <jan.bernatik@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: platform device / driver question
Message-ID: <20060825170705.GA1655@buici.com>
References: <dca824fc0608250608s3b371291qd313986cffc1e028@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca824fc0608250608s3b371291qd313986cffc1e028@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 03:08:51PM +0200, Jan Bernatik wrote:
> hi, I am newbie to linux kernel development, but I couldn't get my
> question answered on #kernelnewbies, and I am not able to get it right
> from code.
> 
> I studied smc91x driver to understand how platform driver / device
> subsystem works. On #kernelnewbies channel I was told this driver is
> "hopelessly broken". How should one create and register the
> platform_device/driver ? Is the implementation in smc91x correct ?

Whoever told you that the driver is broken is mistaken.  The driver
works well.  The *chip*, on the other hand, isn't the best of show.

The trouble with the SMC chip is that it has only 4 packet buffers.
When it is used in a design with either a relatively slow CPU or in a
design with other IO performance bottlenecks, it will tend to drop
packets as it is very easy for the buffers to fill with incoming data
before the CPU can unload them.  Nico reported excellent throughput on
one board.

> If someone could clarify this, I will appreciate that, and certainly
> write some newbie-understandable documentation. It is not covered by
> LDD AFAIK.
> 
> thanks, have a nice day
> please CC me, I am not on the list
> 
> J.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267074AbRGYRE1>; Wed, 25 Jul 2001 13:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbRGYRER>; Wed, 25 Jul 2001 13:04:17 -0400
Received: from adsl-64-170-199-186.dsl.snfc21.pacbell.net ([64.170.199.186]:33023
	"EHLO orion.ariodata.com") by vger.kernel.org with ESMTP
	id <S267074AbRGYREK> convert rfc822-to-8bit; Wed, 25 Jul 2001 13:04:10 -0400
content-class: urn:content-classes:message
Subject: RE2: Why no modules for IDE chipset support?
Date: Wed, 25 Jul 2001 10:00:06 -0700
Message-ID: <8A098FDFC6EED94B872CA2033711F86F033ACB@orion.ariodata.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Thread-Topic: RE2: Why no modules for IDE chipset support?
Thread-Index: AcEVK0BAj+Kr3RH6T/K5YBi9vm+l1g==
From: "Michael Nguyen" <mnguyen@ariodata.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
To: <linux-kernel@vger.kernel.org>
Cc: "Steven Walter" <srwalter@yahoo.com>,
        "Uwe Bonnes" <bon@elektron.ikp.physik.tu-darmstadt.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

Following up on this question:

The compile Kernel includes IDE module (motherboard controller) for 
booting. Later, I install an additional IDE controller (different 
chip set). Can this be a separate "insmod [module]" from the build
in?

THX, Michael.


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Steven Walter
Sent: Wednesday, July 25, 2001 9:35 AM
To: Uwe Bonnes
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why no modules for IDE chipset support?


On Wed, Jul 25, 2001 at 11:31:25AM +0200, Uwe Bonnes wrote:
> Hallo,
> 
> why are the IDE chipset support driver not modularized? Is there
anything
> fundamental that inhibits using these drivers as a modules?

They are availible as modules.  See "ATA/IDE/MFM/RLL support," which is
a tristate.  If you select that as a module, then all the chipsets you
select for support later will be compiled into one large module.

This is probably a bad idea, though, because if you compile IDE support
as a module, you will not be able to mount your root partition if it is
on an IDE disk.

I hope this clears things up for you.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

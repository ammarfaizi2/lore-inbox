Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269756AbRH0X22>; Mon, 27 Aug 2001 19:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269778AbRH0X2I>; Mon, 27 Aug 2001 19:28:08 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:48584 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S269756AbRH0X2E>; Mon, 27 Aug 2001 19:28:04 -0400
Message-ID: <3B8AD78A.C0C858F2@bigfoot.com>
Date: Mon, 27 Aug 2001 16:28:10 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p9ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jamie@versado.net
CC: linux-kernel@vger.kernel.org
Subject: Re: HPT370 driver problems continued...
In-Reply-To: <CKEAJKBNHMOBPBEDFFPHGEMLCAAA.jamie@versado.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder whether this could be a compatiblity issue between drive and
> controller - both Edward and myself are using similar IBM Deskstar models -
> anyone else had problems with these drives?

> >       30Gb IBM DTLA 307030

This drive is mentioned in hpt366.c.  You might want to check
~/drivers/block/hpt370.c.

const char *bad_ata66_4[] = {
        "IBM-DTLA-307075",
        "IBM-DTLA-307045",
        "IBM-DTLA-307030",
        "WDC AC310200R",
        NULL
};

> >                   The initial hardware configuration
> >                   had two 40G IBM drives (7200RPM
> >                   UDMA100) each attached as the IDE
> >                   Master (using cable select) of the
> >                   primary and secondary IDE interfaces

I don't think cable select is commonly used.  All the IDE RAID setups
I've done use a single disk/controller channel, all IDE Masters.

rgds,
tim.

--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137158AbREKPm7>; Fri, 11 May 2001 11:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137159AbREKPmt>; Fri, 11 May 2001 11:42:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:52996 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S137158AbREKPmf>; Fri, 11 May 2001 11:42:35 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: LVM 1.0 release decision
Date: 11 May 2001 08:42:13 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9dh18l$evk$1@cesium.transmeta.com>
In-Reply-To: <20010511162745.B18341@sistina.com> <E14yDyI-0000yE-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E14yDyI-0000yE-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> A new format is fine but import old ones properly. And if you do a new format
> stop using kdev_t on disk - it will change size soon
> 

Not to mention that it might end up being a pointer, or go away (to be
replaced with kchrdev_t, kblkdev_t or something like that.)

*** kdev_t does not belong in user space or on disk; it is a kernel
    transient object. ***

Personally I can't believe this code went into the mainstream kernel
*at all* with this wart in it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

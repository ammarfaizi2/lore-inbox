Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131018AbRCZIqt>; Mon, 26 Mar 2001 03:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131884AbRCZIqj>; Mon, 26 Mar 2001 03:46:39 -0500
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:62218 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S131018AbRCZIqX>; Mon, 26 Mar 2001 03:46:23 -0500
Message-ID: <3ABF01A5.4D48314E@stud.uni-saarland.de>
Date: Mon, 26 Mar 2001 08:45:25 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: mingo@elte.hu
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] pae-2.4.3-A4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> plus i took to opportunity to reduce the allocation size of PAE-pgds. 
> Their size is only 32 bytes, and we allocated a full page. Now the code 
> kmalloc()s a 32 byte cacheline for the pgd. (there is a hardware 
> constraint on alignment: this cacheline must be at least 16-byte aligned, 
> which is true for the current kmalloc() code.)

No, it isn't ;-)

Just enable slab debugging (it's a kernel option in alan's ac kernels),
and then the kmalloc result is not aligned anymore.

--
	Manfred

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRCEJkk>; Mon, 5 Mar 2001 04:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129131AbRCEJka>; Mon, 5 Mar 2001 04:40:30 -0500
Received: from 4dyn174.delft.casema.net ([195.96.105.174]:27153 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129116AbRCEJkS>; Mon, 5 Mar 2001 04:40:18 -0500
Message-Id: <200103050940.KAA21120@cave.bitwizard.nl>
Subject: Re: kmalloc() alignment
In-Reply-To: <E14Zh5G-0005tP-00@the-village.bc.nu> from Alan Cox at "Mar 4, 2001
 10:34:31 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 5 Mar 2001 10:40:05 +0100 (MET)
CC: Kenn Humborg <kenn@linux.ie>, Linux-Kernel <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Does kmalloc() make any guarantees of the alignment of allocated
> > blocks?  Will the returned block always be 4-, 8- or 16-byte
> > aligned, for example?
 
> There are people who assume 16byte alignment guarantees. I dont
> think anyone has formally specified the guarantee beyond 4 bytes tho

What does "formally specified" mean? 

As far as I know, you can count on 16-bytes alignment from
kmalloc. The trouble is that you would have to keep the original
pointer and free that if you have to do the "round" yourself. 

I once wrote a kmalloc(*) that would allow you to free any pointer
inside the kmalloc-ed area. This is dangerous as freeing a random
pointer is more likely to "work". But in this case it would be very
convenient.

			Roger.

(*) Too buggy for anyone but me. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

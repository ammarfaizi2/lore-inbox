Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUHIE5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUHIE5f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 00:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266002AbUHIE5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 00:57:34 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:15567 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S265999AbUHIE5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 00:57:21 -0400
Date: Sun, 8 Aug 2004 21:56:24 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: "Eric D. Mudama" <edmudama@bounceswoosh.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Jakma <paul@clubi.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: libata: dma, io error messages
In-Reply-To: <20040809044839.GA18961@bounceswoosh.org>
Message-ID: <Pine.LNX.4.60.0408082149480.29473@twin.uoregon.edu>
References: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org>
 <1091795565.16307.14.camel@localhost.localdomain> <4113A684.8050302@pobox.com>
 <20040809044839.GA18961@bounceswoosh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004, Eric D. Mudama wrote:

> On Fri, Aug  6 at 11:40, Jeff Garzik wrote:
>> libata does not (yet) retry cable errors, for example.  Paul, don't 
>> automatically assume the disk is bad, try swapping cables.
>
> In practice with large #s of drives, cable errors are a given, even
> with good cables... eventually *something* is going to glitch, we see
> it all the time in our testing, especially at elevated temperatures.

I can corroborate this using different drivers (3ware in this case) with 
12 drivers and 4 backplanes per chassis most of our failures have been due 
to disks erroring out on the 3ware rather than actual failed drives. we 
pull the disks, test them and return them to the chassis as spares if 
they're functional. It doesn't happen that often but we have quite a few 
of these things now (~10TB) so it does happen.

> --eric
>
>
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2


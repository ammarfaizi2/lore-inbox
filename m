Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317653AbSGZJgo>; Fri, 26 Jul 2002 05:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317657AbSGZJgn>; Fri, 26 Jul 2002 05:36:43 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:60409 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317653AbSGZJgn>; Fri, 26 Jul 2002 05:36:43 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1027679991.13428.24.camel@irongate.swansea.linux.org.uk> 
References: <1027679991.13428.24.camel@irongate.swansea.linux.org.uk>  <3D40A3E4.9050703@snapgear.com> <3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com> <9143.1027671559@redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 10:39:48 +0100
Message-ID: <12015.1027676388@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  It doesn't work with an MMU either. Consider O_DIRECT file writing
> from such a page

Hmmm. 

O_DIRECT writing of data from an XIP-mapped page to a file on the same chip 
ain't ever going to work. Writing to something elsewhere should be fine -- 
if a page is locked when the chip driver wants to go talk to the chip, the 
chip driver has to wait for that page to become unlocked. No?

--
dwmw2



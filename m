Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317661AbSGZJi7>; Fri, 26 Jul 2002 05:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317662AbSGZJi7>; Fri, 26 Jul 2002 05:38:59 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32244 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317661AbSGZJi6>; Fri, 26 Jul 2002 05:38:58 -0400
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
In-Reply-To: <12015.1027676388@redhat.com>
References: <1027679991.13428.24.camel@irongate.swansea.linux.org.uk> 
	<3D40A3E4.9050703@snapgear.com> <3D3FA130.6020701@snapgear.com>
	<9309.1027608767@redhat.com> <9143.1027671559@redhat.com>  
	<12015.1027676388@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 11:56:04 +0100
Message-Id: <1027680964.13428.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 10:39, David Woodhouse wrote:
> 
> alan@lxorguk.ukuu.org.uk said:
> >  It doesn't work with an MMU either. Consider O_DIRECT file writing
> > from such a page
> 
> Hmmm. 
> 
> O_DIRECT writing of data from an XIP-mapped page to a file on the same chip 
> ain't ever going to work. Writing to something elsewhere should be fine -- 
> if a page is locked when the chip driver wants to go talk to the chip, the 
> chip driver has to wait for that page to become unlocked. No?

Now consider two events each locking the page the other wishes to write
to. At that point you may want to stop digging any deeper holes


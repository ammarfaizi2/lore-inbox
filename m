Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSGZNdq>; Fri, 26 Jul 2002 09:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317709AbSGZNdp>; Fri, 26 Jul 2002 09:33:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48373 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317708AbSGZNdp>; Fri, 26 Jul 2002 09:33:45 -0400
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
In-Reply-To: <12441.1027677534@redhat.com>
References: <1027680964.13428.37.camel@irongate.swansea.linux.org.uk> 
	<1027679991.13428.24.camel@irongate.swansea.linux.org.uk>
	<3D40A3E4.9050703@snapgear.com> <3D3FA130.6020701@snapgear.com>
	<9309.1027608767@redhat.com> <9143.1027671559@redhat.com>
	<12015.1027676388@redhat.com>   <12441.1027677534@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 15:50:29 +0100
Message-Id: <1027695029.13428.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 10:58, David Woodhouse wrote:
> 
> alan@lxorguk.ukuu.org.uk said:
> >  Now consider two events each locking the page the other wishes to
> > write to. At that point you may want to stop digging any deeper holes 
> 
> Maybe, but only if we can come up with a better alternative. 
> 
> Bear in mind that XIP is not for general-purpose use, and strict 
> restrictions on what you can do with it are not unreasonable. Assume we 
> remove O_DIRECT support entirely from any kernel which supports XIP. Then 
> what breaks?

Anything where you rely on locking the pages and can get a loop of
locked/absent pages and deadlock

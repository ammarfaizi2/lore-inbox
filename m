Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317877AbSGZP56>; Fri, 26 Jul 2002 11:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317878AbSGZP56>; Fri, 26 Jul 2002 11:57:58 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:11511 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317877AbSGZP55>; Fri, 26 Jul 2002 11:57:57 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1027703485.13429.53.camel@irongate.swansea.linux.org.uk> 
References: <1027703485.13429.53.camel@irongate.swansea.linux.org.uk>  <1027695029.13428.45.camel@irongate.swansea.linux.org.uk> <1027680964.13428.37.camel@irongate.swansea.linux.org.uk> <1027679991.13428.24.camel@irongate.swansea.linux.org.uk> <3D40A3E4.9050703@snapgear.com> <3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com> <9143.1027671559@redhat.com> <12015.1027676388@redhat.com> <12441.1027677534@redhat.com> <26333.1027692205@redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 17:01:05 +0100
Message-ID: <6881.1027699265@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Well for a starter lets try user writing a block to flash which needs
> an erase from a block which happens to be not yet paged in and so
> still on the flash you are writing to.

What locks the page? Surely our write() implementation is just using 
copy_from_user(), to get the data from the user, and each erase and write 
to the flash chip can be considered atomic -- what's holding a lock, and 
what's causing the deadlock?

--
dwmw2



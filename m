Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317432AbSGZJzs>; Fri, 26 Jul 2002 05:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSGZJzs>; Fri, 26 Jul 2002 05:55:48 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:23802 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317432AbSGZJzr>; Fri, 26 Jul 2002 05:55:47 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1027680964.13428.37.camel@irongate.swansea.linux.org.uk> 
References: <1027680964.13428.37.camel@irongate.swansea.linux.org.uk>  <1027679991.13428.24.camel@irongate.swansea.linux.org.uk> <3D40A3E4.9050703@snapgear.com> <3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com> <9143.1027671559@redhat.com> <12015.1027676388@redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Ungerer <gerg@snapgear.com>, linux-kernel@vger.kernel.org,
       David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 10:58:54 +0100
Message-ID: <12441.1027677534@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Now consider two events each locking the page the other wishes to
> write to. At that point you may want to stop digging any deeper holes 

Maybe, but only if we can come up with a better alternative. 

Bear in mind that XIP is not for general-purpose use, and strict 
restrictions on what you can do with it are not unreasonable. Assume we 
remove O_DIRECT support entirely from any kernel which supports XIP. Then 
what breaks?

--
dwmw2



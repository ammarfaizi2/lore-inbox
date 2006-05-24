Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWEXReG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWEXReG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWEXReG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:34:06 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.25]:16219 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932600AbWEXReF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:34:05 -0400
X-ME-UUID: 20060524173403560.88E121C000C3@mwinf0612.wanadoo.fr
Subject: Re: OpenGL-based framebuffer concepts
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: Matheus Izvekov <mizvekov@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       "D. Hazelton" <dhazelton@enter.net>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <4474891D.9010205@ums.usu.ru>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>
	 <200605230048.14708.dhazelton@enter.net>
	 <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com>
	 <6896241F-3389-4B20-9E42-3CCDDBFDD312@mac.com>
	 <44740533.7040702@aitel.hist.no> <447465C6.3090501@ums.usu.ru>
	 <9e4733910605240749r1ce9e9fehcfffb2f2e3aeab60@mail.gmail.com>
	 <44747432.1090906@ums.usu.ru>
	 <305c16960605240915p7961ddbfye90afd3cf7fbc372@mail.gmail.com>
	 <4474891D.9010205@ums.usu.ru>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 24 May 2006 19:34:22 +0200
Message-Id: <1148492064.16503.1.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 24 mai 2006 à 22:26 +0600, Alexander E. Patrakov a écrit :
> Now suppose this.
> 
> The kernel has to save the video memory contents somewhereto restore it after 
> pressing Enter. This may swap something out. Whoops, swap is on that failed disk.
> 
> Or: lock the memory in advance, to avoid the use of swap. But this is not better 
> than doing the same thing from a userspace application that shows a pop-up 
> ballon with the contents of this oops. And it won't be affected by a disk 
> failure, because it has everything already in memory.

Don't save the framebuffer. Just send a message to the client
application saying "fb is corrupted, please redraw". X11 can do it,
console can do it.

	Xav



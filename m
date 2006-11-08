Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965915AbWKHPO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965915AbWKHPO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965918AbWKHPO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:14:57 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8130 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965915AbWKHPO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:14:56 -0500
Subject: Re: VIA IRQ quirk missing PCI ids since 2.6.16.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wilco Beekhuizen <wilcobeekhuizen@gmail.com>
Cc: Dave Jones <davej@redhat.com>,
       Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <6c4c86470611080054r21f5c632u674da23bf3d1cc32@mail.gmail.com>
References: <6c4c86470611060338j7f216e26od93e35b4b061890e@mail.gmail.com>
	 <1162817254.5460.4.camel@localhost.localdomain>
	 <1162847625.10086.36.camel@localhost.localdomain>
	 <20061107012519.GC25719@redhat.com>
	 <1162863274.11073.41.camel@localhost.localdomain>
	 <6c4c86470611080054r21f5c632u674da23bf3d1cc32@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 15:19:08 +0000
Message-Id: <1162999148.23956.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-08 am 09:54 +0100, ysgrifennodd Wilco Beekhuizen:
> Why was this changed in the stable kernel anyway, especially in a
> micro-stability update? It seems to me it breaks more than it fixes.

Because it suffered from an acute case of being wrong. The blanket patch
proposed by Sergio is also wrong. Both break valid correct and working
systems while fixing some others.

The draft patch I posted fixes up precisely the right devices on
precisely the right bridges and nothing else which should mean we now
have a patch that gets all cases right.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263633AbRFARkx>; Fri, 1 Jun 2001 13:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263634AbRFARkn>; Fri, 1 Jun 2001 13:40:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46857 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263633AbRFARk2>; Fri, 1 Jun 2001 13:40:28 -0400
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for
To: mark@somanetworks.com (Mark Frazer)
Date: Fri, 1 Jun 2001 18:37:48 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        bogdan.costescu@iwr.uni-heidelberg.de (Bogdan Costescu),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        zaitcev@redhat.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20010601103749.C5248@somanetworks.com> from "Mark Frazer" at Jun 01, 2001 10:37:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155srs-0000nu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd argue for rate limiting as the application only gets back new data,
> never a cached value n times in a row.

No the application gets back no data, ever, because a third party application
keeps beating it. You don't even need maliciousness for this, synchronization
effects and locking on the file will ensure it gets you in the end

> With caching, you'd have to let the application know when the cached
> value was last read and how long it will be cached for.  With rate

fstat() mtime. That seems easy enough


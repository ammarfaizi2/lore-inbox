Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288978AbSBIPbp>; Sat, 9 Feb 2002 10:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288980AbSBIPb1>; Sat, 9 Feb 2002 10:31:27 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:9999 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S288978AbSBIPbE>; Sat, 9 Feb 2002 10:31:04 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Sat, 9 Feb 2002 15:14:15 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020209151414.A18937@bytesex.org>
In-Reply-To: <3C630D5D.CD66795@zip.com.au> <Pine.LNX.4.21.0202081649120.1497-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202081649120.1497-100000@localhost.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and Gerd Knorr's report (extracts below) implies that his bttv driver
> was calling unmap_kiobuf at interrupt time.  Is that right, Gerd?

Yes.

> encourage him to unmap at interrupt time).  Now maybe Gerd's code is
> wrong anyway: a quick look suggests it may also vfree there, which
> would be wrong at interrupt time.

vfree() isn't allowed?  I know vmalloc() isn't because it might sleep
while waiting for the VM getting a few free pages.  Why vfree isn't
allowed?  I can't see why freeing ressources is a problem ...

Is somewhere a list of things which are allowed from irq context and
which are not?

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */

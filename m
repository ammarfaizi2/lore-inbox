Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSFKDOk>; Mon, 10 Jun 2002 23:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSFKDOj>; Mon, 10 Jun 2002 23:14:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42176 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316663AbSFKDOj>;
	Mon, 10 Jun 2002 23:14:39 -0400
Date: Mon, 10 Jun 2002 20:10:33 -0700 (PDT)
Message-Id: <20020610.201033.66168406.davem@redhat.com>
To: wjhun@ayrnetworks.com
Cc: paulus@samba.org, roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020610110740.B30336@ayrnetworks.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wait a second, forget all of this cache alignment crap.  If we can
avoid drivers seeing it, we should by all means necessary.

We should just tell people to use PCI pools and be done with it.  That
way all the complexity about buffer alignment and all this other
crapola lives strictly inside of the PCI pool code.

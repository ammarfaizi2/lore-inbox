Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSGUMeg>; Sun, 21 Jul 2002 08:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSGUMeg>; Sun, 21 Jul 2002 08:34:36 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35317 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314395AbSGUMef>; Sun, 21 Jul 2002 08:34:35 -0400
Subject: Re: [PATCH] generalized spin_lock_bit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: rml@tech9.net, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@conectiva.com.br,
       wli@holomorphy.com
In-Reply-To: <20020720.183133.67807986.davem@redhat.com>
References: <1027196511.1555.767.camel@sinai>
	<20020720.152703.102669295.davem@redhat.com>
	<1027211185.17234.48.camel@irongate.swansea.linux.org.uk> 
	<20020720.183133.67807986.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 14:48:54 +0100
Message-Id: <1027259334.16819.98.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 02:31, David S. Miller wrote:
> For an asm-generic/bitlock.h implementation it is more than
> fine.  That way we get asm-i386/bitlock.h that does whatever
> it wants to do and the rest of asm-*/bitlock.h includes
> the generic version until the arch maintainer sees fit to
> do otherwise.

For an asm-generic one yes. Although you do need to add a cpu_relax() in
the inner loop

Alan


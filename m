Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267697AbRGPUpC>; Mon, 16 Jul 2001 16:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267698AbRGPUow>; Mon, 16 Jul 2001 16:44:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33920 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267697AbRGPUoq>;
	Mon, 16 Jul 2001 16:44:46 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15187.21029.24931.310840@pizda.ninka.net>
Date: Mon, 16 Jul 2001 13:44:21 -0700 (PDT)
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jens Axboe <axboe@suse.de>, Jes Sorensen <jes@sunsite.dk>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit
 machine
In-Reply-To: <Pine.LNX.4.30.0107161601480.23444-100000@biker.pdb.fsc.net>
In-Reply-To: <Pine.LNX.4.30.0107161601480.23444-100000@biker.pdb.fsc.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Wilck writes:
 > Thus the IA-64 API will probably emerge as a matter-of-fact standard

It is, and can only be, an IA-64 hack, not an API.  This hack simply
cannot work at all on any 32-bit platform.  Only an API using page +
offset + len triplets can work successfully on all platforms.

And I think the new aic7xxx driver can be made to work just fine, and
the fact that the old aic7xxx driver is able to be nice to the IO
mapping allocator pool (AND get decent performance) is evidence of
this.  Really, what I hear sounds like merely a cop out.

Later,
David S. Miller
davem@redhat.com

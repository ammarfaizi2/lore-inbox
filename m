Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266800AbRGKVyp>; Wed, 11 Jul 2001 17:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266802AbRGKVyg>; Wed, 11 Jul 2001 17:54:36 -0400
Received: from weta.f00f.org ([203.167.249.89]:64642 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266800AbRGKVyZ>;
	Wed, 11 Jul 2001 17:54:25 -0400
Date: Thu, 12 Jul 2001 09:54:21 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jes Sorensen <jes@sunsite.dk>
Cc: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Ben LaHaise <bcrl@redhat.com>,
        "\"MEHTA,HIREN (A-SanJose,ex1)\"" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
Message-ID: <20010712095421.A2298@weta.f00f.org>
In-Reply-To: <3B46FDF1.A38E5BB6@mandrakesoft.com> <E15Ir5R-0005lR-00@the-village.bc.nu> <15175.2003.773317.101601@pizda.ninka.net> <d3y9pv8ee5.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3y9pv8ee5.fsf@lxplus015.cern.ch>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 09:16:50PM +0200, Jes Sorensen wrote:

    The overhead is going be negligeble, the overhead of highmem itself is
    much worse. Not to mention that today some dma_addr_t's might not be
    packed properly in data structure hence they ending up taking 8 bytes
    anyway.

What kind of packing makes a 32-bit value take 8-bytes on any
currently supported archicture? The worst-case I can think of is
7-bytes in the case of misaligned by 3 (e.g. __attribute__((packed))
struct blah { char foo[3]; long bar }; sort of thing).




  --cw

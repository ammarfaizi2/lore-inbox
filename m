Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132260AbRAGR5c>; Sun, 7 Jan 2001 12:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136191AbRAGR5W>; Sun, 7 Jan 2001 12:57:22 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:17907 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S132260AbRAGR5M>; Sun, 7 Jan 2001 12:57:12 -0500
Date: Sun, 7 Jan 2001 14:09:17 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Steve.Ralston@lsil.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptctl.c memory leak on failure
Message-ID: <20010107140917.A8810@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve.Ralston@lsil.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010107011226.C8362@conectiva.com.br> <E14FG0b-0002dZ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14FG0b-0002dZ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Jan 07, 2001 at 01:37:15PM +0000
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 07, 2001 at 01:37:15PM +0000, Alan Cox escreveu:
> > kmalloc and the comment: the buffer is used for DMA but the kmalloc doesn't
> > has GFP_DMA, maybe I'm missing something here, its about time for me to
> 
> It should be kmalloc (or 2.4 wise pci_alloc_* I guess eventually). Its driven
> by 32bit busmaster DMA. Its non ISA so it doesnt need GFP_DMA

yap, I should have have some sleep before suggesting that 8) Now back
looking at the other files, I've found another not so grave potential
memory leak, patch in some minutes

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130807AbRAKU4z>; Thu, 11 Jan 2001 15:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130805AbRAKU4g>; Thu, 11 Jan 2001 15:56:36 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:31988 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129631AbRAKU4R>; Thu, 11 Jan 2001 15:56:17 -0500
Date: Thu, 11 Jan 2001 17:09:03 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Paul Powell <moloch16@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux driver:  __get_free_pages()
Message-ID: <20010111170903.A9711@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Paul Powell <moloch16@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010111203933.17385.qmail@web119.yahoomail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010111203933.17385.qmail@web119.yahoomail.com>; from moloch16@yahoo.com on Thu, Jan 11, 2001 at 12:39:33PM -0800
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 11, 2001 at 12:39:33PM -0800, Paul Powell escreveu:

> Our driver is trying to allocate a DMA buffer to flash an adapter's
> firmware.  This can require as much as 512K ( of contiguous DMA memory ).
> We are using the function __get_free_pages( GFP_KERNEL | GFP_DMA, order)
> .  The call is failing if 'order' is greater than 6.  The problem is seen
> on systems with system memory of only 64MB.  It works fine on systems
> with more memory.  Does it make sense that a system with 64MB would not
> have 512K ( contiguous ) available?  The most that can be allocated
> successfully on the 64MB system appears to be 256K.  (Nothing else is
> running that would eat up 64MB of memory).
 
> Does this make sense and/or is there another way that the DMA memory
> could be allocated successfully?

look at mm/bootmem.c

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

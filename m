Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSALNPJ>; Sat, 12 Jan 2002 08:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286215AbSALNO7>; Sat, 12 Jan 2002 08:14:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35408 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286207AbSALNOt>; Sat, 12 Jan 2002 08:14:49 -0500
Date: Sat, 12 Jan 2002 14:14:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, bcrl@redhat.com,
        axboe@suse.de, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Mostly PAGE_SIZE IO for RAW (NEW VERSION)
Message-ID: <20020112141411.K1482@inspiron.school.suse.de>
In-Reply-To: <200201112351.g0BNp8912572@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200201112351.g0BNp8912572@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Fri, Jan 11, 2002 at 03:51:08PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 03:51:08PM -0800, Badari Pulavarty wrote:
> +					iosize = PAGE_SIZE - offset;

BTW, I'd be careful with true PAGE_SIZE I/O, PAGE_SIZE can be easily as
large as 32k and not every driver is been tested to digest a b_size of
32k, so I'd use 4k instead, noop for x86 so I think you won't mind to go
safe here :). I'd define a RAWIO_BLOCKSIZE in iobuf.h defined to 4096.

Andrea

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313562AbSDHGFk>; Mon, 8 Apr 2002 02:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313566AbSDHGFj>; Mon, 8 Apr 2002 02:05:39 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:24211 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S313564AbSDHGFh>; Mon, 8 Apr 2002 02:05:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>, nahshon@actcom.co.il
Subject: Re: faster boots?
Date: Mon, 8 Apr 2002 08:02:58 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Pavel Machek <pavel@suse.cz>, Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        joeja@mindspring.com, linux-kernel@vger.kernel.org
In-Reply-To: <E16tTAF-0008F2-00@the-village.bc.nu> <200204080048.g380mt514749@lmail.actcom.co.il> <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16uSEQ-1XziYCC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > and spin-up on any operation that writes to the disk (and block that
> > operation).
>
> Absolutely not! I don't want my writes to spin up the drive.

Even if you sync ?

> > The opposite to that (which I do not like) processes create as many
> > dirty buffers as they want and disk spins up only on sync() or when
> > the system is starving for usable memory.
>
> Maybe you don't like that, but many of us with laptops prefer that
> behaviour. And for many reasons, it is definately the correct
> behaviour.

You are definitely right. I'd even wish for swapping out stuff and doing
a drastic read ahead before spinning down.

> > An aletrnate ides (more drastic) is that fle systems can mount
> > internally read-only when a disk is spinned-down. Means - you cannot
> > spin down when there is a file handle open for writing. Other than
> > this there are advantages.
>
> Undesirable behaviour.

Absolutely. One disk is typical and log files will be open.

	Regards
		Oliver

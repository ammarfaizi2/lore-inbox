Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131678AbQLGXpP>; Thu, 7 Dec 2000 18:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130029AbQLGXpG>; Thu, 7 Dec 2000 18:45:06 -0500
Received: from 62-6-231-122.btconnect.com ([62.6.231.122]:35588 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129645AbQLGXo5>;
	Thu, 7 Dec 2000 18:44:57 -0500
Date: Thu, 7 Dec 2000 23:16:19 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andreas Klein <asklein@cip.physik.uni-wuerzburg.de>,
        linux-kernel@vger.kernel.org, drew@colorado.edu
Subject: Re: bug in scsi.c
In-Reply-To: <E144ACA-00038L-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012072314021.933-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Alan Cox wrote:
> > > > A proper way to release the references to resources is to call daemonize()
> > > > function from within the kernel thread function, which calls
> > > > exit_fs()/exit_files() internally.
> > > 
> > > Nearly correct, the daemonize function does NOT call exit_files.
> > 
> > I do not post messages to linux-kernel without checking the facts
> > first. Read the daemonize() function and see for yourself that you are
> > wrong.
> 
> Andreas is looking at a slightly older kernel, and was right for that. Every
> caller to daemonize either then did the file stuff or needed to and forgot
> so I fixed daemonize

Yes, yes, Alan, I do know that. I just took it for granted that the
correctness of the statement when applied to the latest kernel should not
upset someone who is looking at the older version so me calling someone
"wrong" is not a strong offensive term, just a mild thing saying "guess
what -- things changed". Just trying to exercise the human mind to get
used to quick changes in the Linux world -- that is all :)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

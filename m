Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbQLLVJ1>; Tue, 12 Dec 2000 16:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLLVJS>; Tue, 12 Dec 2000 16:09:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:30994 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129543AbQLLVJB>; Tue, 12 Dec 2000 16:09:01 -0500
Date: Tue, 12 Dec 2000 12:38:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steven Cole <scole@lanl.gov>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <00121213193501.00861@spc.esa.lanl.gov>
Message-ID: <Pine.LNX.4.10.10012121236360.2553-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2000, Steven Cole wrote:
> 
> Task: make -j3 bzImage for 2.4.0-test12-pre7 kernel tree.

Actually, do it with

	make -j3 'MAKE=make -j3' bzImage

A single "-j3" won't do much. It will only build three directories at a
time, and you'll never see much load. But doing it recursively means that
you'll build three at a time all the way out to the leaf directories, and
you should see loads up to 20+, and much more memory pressure too.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbUBBANj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 19:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265610AbUBBANj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 19:13:39 -0500
Received: from intra.cyclades.com ([64.186.161.6]:17324 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265609AbUBBANh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 19:13:37 -0500
Date: Sun, 1 Feb 2004 22:13:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Mike Gabriel <mgabriel@ecology.uni-kiel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failed in 2.4.24
In-Reply-To: <200402010018.23725.mgabriel@ecology.uni-kiel.de>
Message-ID: <Pine.LNX.4.58L.0402012151510.2331@logos.cnet>
References: <200402010018.23725.mgabriel@ecology.uni-kiel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Feb 2004, Mike Gabriel wrote:

> hi there,
>
> can anyone tell me what these messages mean? running linux-2.4.24 on asus
> p4p800 deluxe.
>
> Jan 31 02:38:02 galileo kernel: __alloc_pages: 0-order allocation failed
> (gfp=0xf0/0)
> Jan 31 02:38:02 galileo kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0)
> Jan 31 02:38:02 galileo kernel: VM: killing process slapd
> Jan 31 02:38:50 galileo kernel: __alloc_pages: 0-order allocation failed
> (gfp=0xf0/0)
> Jan 31 02:38:50 galileo kernel: ENOMEM in journal_get_undo_access_R9add2900,
> retrying.
> Jan 31 02:38:53 galileo kernel: __alloc_pages: 0-order allocation failed
> (gfp=0xf0/0)
> Jan 31 02:39:19 galileo last message repeated 3 times
> Jan 31 02:39:25 galileo kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0)
> Jan 31 02:39:25 galileo kernel: VM: killing process sshd
> Jan 31 02:39:25 galileo kernel: __alloc_pages: 0-order allocation failed
> (gfp=0x1d2/0)
> Jan 31 02:39:25 galileo kernel: VM: killing process sshd
>
> I get plenty of them during copying (cp -av <source> <dest>) a huge amount of
> data, which is densely filled with hard links from one raid to another... the
> cp command runs in a screen session. on huge directories, it starts blasting
> other processes from the system (sshd, nmbd, spong-client, etc.)

Hi Mike,

How much swap do you have on this system and how much swap space is free
when you start seeing the allocation failures?

"vmstat 2" output (start it before running the tests) and "cat
/proc/slabinfo" output (before and during the tests) are useful to find
out what is happening.


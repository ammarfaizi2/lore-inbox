Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283783AbRLRO14>; Tue, 18 Dec 2001 09:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284038AbRLRO1q>; Tue, 18 Dec 2001 09:27:46 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:15076 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S283783AbRLRO1p>; Tue, 18 Dec 2001 09:27:45 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: 2.4.16 memory badness (reproducible)
Date: Tue, 18 Dec 2001 15:27:44 +0100
Organization: Internet Factory AG
Message-ID: <3C1F5260.2F468E0C@internet-factory.de>
In-Reply-To: <200112082142.fB8LgAb02089@orp.orf.cx> <Pine.LNX.4.21.0112111850090.1164-100000@localhost.localdomain> <20011211235908.L4801@athlon.random>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1008685664 13362 195.122.142.158 (18 Dec 2001 14:27:44 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 18 Dec 2001 14:27:44 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac7 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli proclaimed:

> He always get vmalloc failures, this is way too suspect. If the VM
> memory balancing was the culprit he should get failures with all the
> other allocations too. So it has to be a problem with a shortage of the
> address space available to vmalloc, not a problem with the page
> allocator.

Leigh pointed me to your post in reply to another thread (modify_ldt
failing on highmem machine).

Is there any special vmalloc handling on highmem kernels? I only run
into the problem if I am using high memory support in the kernel. I
haven't been able to reproduce the problem with 896M or less, which
strikes me as slightly odd. Why does _more_ memory trigger "no memory"
failures?

The problem is indeed not vm specific. the last -ac kernel shows the
problem, too (and that one still has the old vm, doesn't it?)

Holger

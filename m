Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135719AbREFPgp>; Sun, 6 May 2001 11:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135720AbREFPgf>; Sun, 6 May 2001 11:36:35 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:9487 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S135719AbREFPgb>; Sun, 6 May 2001 11:36:31 -0400
Date: Sun, 6 May 2001 18:47:28 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Don Dugger <n0ano@valinux.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Thread core dumps for 2.4.4
In-Reply-To: <20010503085418.A12123@tlaloc.n0ano.com>
Message-ID: <Pine.LNX.4.30.0105061833220.16238-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 May 2001, Don Dugger wrote:

> The attached patch allows core dumps from thread processes in the 2.4.4
> kernel.  This patch is the same as the last one I sent out except it fixes
> the same bug that `kernel/fork.c' had with duplicate info in the `mm'
> structure, plus this patch has had more extensive testing.

AFAIK Linux can't dump the threads to the same file as others but doing
it to different files looks a bit scary. How the system behaves when you
dump a heavy threaded app with a decent VM [i.e just think about a
bloatware instead of malicious code]? How will the developer know which
thread caused the fault? I've found dumping just the faulting thread is
enough about 100% of the cases especially because [on SMP] others can
run on and the dump is much more close to "garbage" then usuful info
from a debug point of view.

	Szaka


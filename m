Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129977AbQLLK6z>; Tue, 12 Dec 2000 05:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130121AbQLLK6q>; Tue, 12 Dec 2000 05:58:46 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:18677 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129977AbQLLK6k>; Tue, 12 Dec 2000 05:58:40 -0500
Date: Tue, 12 Dec 2000 08:27:31 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Steven Cole <elenstev@mesatop.com>
cc: linux-kernel@vger.kernel.org, vii@penguinpowered.com,
        mojomofo@mojomofo.com
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <00121116022700.12045@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0012120817130.13641-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Steven Cole wrote:

> Building kernels is something we do so frequently and this test
> is so easy to reproduce is why I performed it in the first
> place.  I think it may be as good a test of real performance as
> some of the more formal benchmarks. Comments anyone?

Just one comment.  You cannot use a kernel build to measure
other things than those subsystems which the kernel build
excercises.

Things you could measure with a kernel build:  scheduling (L2
cache efficiency), fork, readahead, cpu speed, framebuffer
speed (in the make dep phase) and maybe hard disk speed.

Things you cannot measure with a kernel build: networking,
swapping (unless you do a very big parallel build, and even
then it's questionable), raw IO speed (the kernel build is
latency sensitive, but doesn't need much throughput), ...

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbQLNRr0>; Thu, 14 Dec 2000 12:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130125AbQLNRrH>; Thu, 14 Dec 2000 12:47:07 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:60151 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129784AbQLNRqz>; Thu, 14 Dec 2000 12:46:55 -0500
Date: Thu, 14 Dec 2000 15:16:06 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Jussi Laako <jussi.laako@imagesoft.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory subsystem error and freeze on 2.4.0-test12
In-Reply-To: <3A38A825.DE416521@imagesoft.fi>
Message-ID: <Pine.LNX.4.21.0012141515070.1437-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000, Jussi Laako wrote:

> Is this normal:
> 
> Dec 14 12:33:32 alien kernel: __alloc_pages: 2-order allocation failed.

This means that somebody tried to allocate a physically 
contiguous area of 2^2 = 8 pages, but such an area
wasn't available.

> System deadlocked about one minute later.

Any idea which part of the kernel deadlocked? Was it
the network driver, the VM subsystem, .... ?

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

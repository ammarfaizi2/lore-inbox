Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQJ3JEe>; Mon, 30 Oct 2000 04:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbQJ3JEY>; Mon, 30 Oct 2000 04:04:24 -0500
Received: from chiara.elte.hu ([157.181.150.200]:43270 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129029AbQJ3JEK>;
	Mon, 30 Oct 2000 04:04:10 -0500
Date: Mon, 30 Oct 2000 11:13:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030015546.B19869@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301109280.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> No argument here, but the overhead of reloading CR3 period will kill
> performance. [...]

2.4 does not reload CR3, unless you are using multiple user-space
processes.

> 2.4 does not beat NetWare, BTW, it gets a little further, but still
> hits the wall, [...]

as i told you in the previous mail, the main overhead is not CR3, it's the
copying & dirtying of all data, and the subsequent DMA-initiated dirty
cacheline writeback. I can serve 100 MB/sec web content with 2.4 & TUX
just fine - it relies on a zero-copying infrastructure.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

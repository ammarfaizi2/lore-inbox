Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129079AbQJ3Imh>; Mon, 30 Oct 2000 03:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129081AbQJ3Im1>; Mon, 30 Oct 2000 03:42:27 -0500
Received: from chiara.elte.hu ([157.181.150.200]:41734 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129079AbQJ3ImT>;
	Mon, 30 Oct 2000 03:42:19 -0500
Date: Mon, 30 Oct 2000 10:52:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030010808.B19615@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301047030.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> [...] All protection has to go away in all LAN paths for this to
> happen, and user space apps set to ring 0. [...]

i found that this is not a requirement for good network scalability. We do
not do a syscall for every packet, so the cost evens out. Sure, it does
not hurt to not eat ~1 microsecond per system-call, but it causes no
overhead or scalability limit otherwise. In the TUX webserver we have
user-space modules doing context-switch-less webserving, and it scales
quite well, and is generic.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

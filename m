Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131829AbRAHRTH>; Mon, 8 Jan 2001 12:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132404AbRAHRS5>; Mon, 8 Jan 2001 12:18:57 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:51725 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S131941AbRAHRSn>; Mon, 8 Jan 2001 12:18:43 -0500
Date: Mon, 8 Jan 2001 12:18:39 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
To: Andi Kleen <ak@suse.de>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,serious] Fix raid5 crashes in 2.4.0
In-Reply-To: <20010108181625.A11766@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0101081217400.19231-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 Jan 2001, Andi Kleen wrote:

> The following patch fixes an oops in 2.4.0 RAID5 initialisation when
> the kernel was configured without CONFIG_X86_FXSR but is booted on a
> CPU supporting SSE.

yep - my bad, thanks for the fix. Fortunately it crashes at a stage when
there are no filesystems mounted (typically), so there is no other impact,
apart from not being able to boot with this .config.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

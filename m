Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRJFCwp>; Fri, 5 Oct 2001 22:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273506AbRJFCwg>; Fri, 5 Oct 2001 22:52:36 -0400
Received: from [208.129.208.52] ([208.129.208.52]:24836 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S273269AbRJFCw1>;
	Fri, 5 Oct 2001 22:52:27 -0400
Date: Fri, 5 Oct 2001 19:57:49 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Context switch times
In-Reply-To: <200110060224.f962O53104349@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.40.0110051952271.1523-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Albert D. Cahalan wrote:

> If cache problems are bad enough, maybe this pays for itself:
>
> /* old */
> current = stack_ptr & ~0x1fff;
>
> /* new */
> hash = (stack_ptr>>8)^(stack_ptr>>12)^(stack_ptr>>16)^(stack_ptr>>20);
> current = (stack_ptr & ~0x1fff) | (hash & 0x1e0);

I suggested something like this ( randomly "moved" struct task_struct * )
a couple of years ago.
Never tried to measure the impact of the system though.



- Davide



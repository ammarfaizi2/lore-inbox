Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135513AbRARNHl>; Thu, 18 Jan 2001 08:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132960AbRARNHb>; Thu, 18 Jan 2001 08:07:31 -0500
Received: from chiara.elte.hu ([157.181.150.200]:65298 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131462AbRARNHR>;
	Thu, 18 Jan 2001 08:07:17 -0500
Date: Thu, 18 Jan 2001 14:06:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rick Jones <raj@cup.hp.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <3A660746.543226B@cup.hp.com>
Message-ID: <Pine.LNX.4.30.0101181358010.823-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 Jan 2001, Rick Jones wrote:

> i'd heard interesting generalities but no specifics. for instance,
> when the send is small, does TCP wait exclusively for the app to
> flush, or is there an "if all else fails" sort of timer running?

yes there is a per-socket timer for this. According to RFC 1122 a TCP
stack 'MUST NOT' buffer app-sent TCP data indefinitely if the PSH bit
cannot be explicitly set by a SEND operation. Was this a trick question?
:-)

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

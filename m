Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRJNJY6>; Sun, 14 Oct 2001 05:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274991AbRJNJYs>; Sun, 14 Oct 2001 05:24:48 -0400
Received: from zero.aec.at ([195.3.98.22]:61700 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S273622AbRJNJYj>;
	Sun, 14 Oct 2001 05:24:39 -0400
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <3BC9441C.887258DA@welho.com> <20011014.011246.59654800.davem@redhat.com> <3BC94F3A.7F842182@welho.com> <20011014.020326.18308527.davem@redhat.com>
From: Andi Kleen <ak@muc.de>
Date: 14 Oct 2001 11:25:09 +0200
In-Reply-To: "David S. Miller"'s message of "Sun, 14 Oct 2001 02:03:26 -0700 (PDT)"
Message-ID: <k2zo6uiney.fsf@zero.aec.at>
User-Agent: Gnus/5.0700000000000003 (Pterodactyl Gnus v0.83) Emacs/20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011014.020326.18308527.davem@redhat.com>,
"David S. Miller" <davem@redhat.com> writes:

> So, your point is? :-)  A sensible sending application, and a sensible
> TCP should not being setting PSH every single segment.  And we're not
> coding up hacks to make the Linux receiver handle this case better.
> You'll have much better luck convincing us to implement ECN black hole
> workarounds :-)

Ignoring PSH completely on RX would probably not be a worse heuristic 
than forcing an ACK on it. At least other stacks seem to do fine too 
without the force-ack-on-psh. I think you added it a long time ago, but 
I do not remember why you did it; but at least here is an counter example
now that may be a good case for a reconsider.

-Andi

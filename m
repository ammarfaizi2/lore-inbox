Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291989AbSBNXya>; Thu, 14 Feb 2002 18:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291992AbSBNXyK>; Thu, 14 Feb 2002 18:54:10 -0500
Received: from are.twiddle.net ([64.81.246.98]:5257 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S291989AbSBNXyE>;
	Thu, 14 Feb 2002 18:54:04 -0500
Date: Thu, 14 Feb 2002 15:53:55 -0800
From: Richard Henderson <rth@twiddle.net>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
        anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] move task_struct allocation to arch
Message-ID: <20020214155355.A32018@twiddle.net>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
	davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
	anton@samba.org, linux-kernel@vger.kernel.org,
	zippel@linux-m68k.org
In-Reply-To: <jgarzik@mandrakesoft.com> <12214.1013706194@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <12214.1013706194@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Thu, Feb 14, 2002 at 05:03:14PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 05:03:14PM +0000, David Howells wrote:
> Ask Linus, he asked for the task_struct/thread_info split. Various people have
> complained about the two things being allocated separately (maintainers for
> m68k and ia64 archs certainly, and if I remember rightly, x86_64 as well,
> though I don't appear to have saved the message for that). However, DaveM
> (sparc64) appears to really be in favour of it.

I'm not especially in favour of it for Alpha either.

As far as I can see all it's done is added a memory load on the
fast path when a constant displacement folded into the address
would previously have sufficed.



r~

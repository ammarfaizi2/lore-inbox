Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290768AbSBLF1N>; Tue, 12 Feb 2002 00:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290772AbSBLF1C>; Tue, 12 Feb 2002 00:27:02 -0500
Received: from are.twiddle.net ([64.81.246.98]:28293 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S290768AbSBLF0r>;
	Tue, 12 Feb 2002 00:26:47 -0500
Date: Mon, 11 Feb 2002 21:26:44 -0800
From: Richard Henderson <rth@twiddle.net>
To: David Mosberger <davidm@hpl.hp.com>
Cc: "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
Message-ID: <20020211212644.A20387@twiddle.net>
Mail-Followup-To: David Mosberger <davidm@hpl.hp.com>,
	"David S. Miller" <davem@redhat.com>, anton@samba.org,
	linux-kernel@vger.kernel.org, zippel@linux-m68k.org
In-Reply-To: <15464.34183.282646.869983@napali.hpl.hp.com> <20020211.190449.55725714.davem@redhat.com> <15464.35214.669412.477377@napali.hpl.hp.com> <20020211.192334.123921982.davem@redhat.com> <15464.36074.246502.582895@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15464.36074.246502.582895@napali.hpl.hp.com>; from davidm@hpl.hp.com on Mon, Feb 11, 2002 at 07:32:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 07:32:58PM -0800, David Mosberger wrote:
> The kernel has many paths that have sequential dependencies.  If there
> is no other work to do, the compiler won't help you.

Indeed.  A 2 cycle latency on a 4-issue processor means you have
to have quite a large block of code in order for the hot load to
be "free".

On another topic, I'm considering having $8 continue to be current
and using the two-insn stack mask to get current_thread_info and
measuring the size difference that makes.


r~

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132037AbRDJT5N>; Tue, 10 Apr 2001 15:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132038AbRDJT4x>; Tue, 10 Apr 2001 15:56:53 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53121 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132037AbRDJT4q>;
	Tue, 10 Apr 2001 15:56:46 -0400
Message-ID: <3AD3657C.687DA9F7@mandrakesoft.com>
Date: Tue, 10 Apr 2001 15:56:44 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: x86 cpu configuration (was: Re: [PATCH] i386 rw_semaphores fix)
In-Reply-To: <Pine.LNX.4.31.0104101229150.13071-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> That's no problem if we make this SMP-specific - I doubt anybody actually
> uses SMP on i486's even if the machines exist, as I think they all had
> special glue logic that Linux would have trouble with anyway. But the
> advantages of being able to use one generic kernel that works on plain UP
> i386 machines as well as SMP P6+ machines is big enough that I would want
> to be able to say "CONFIG_X86_GENERIC" + "CONFIG_SMP".

(slight tangent)
FWIW I think the i386 CPU selection logic in make config should be
reconsidered in 2.5+...

The alpha presents you with a list of platforms, and allows you to
select a specific one, or a generic option that includes all platforms. 
The current way of doing things on x86 -- essentially selecting a
minimal level of CPU support -- is nice for vendors like Mandrake who
drops support for older CPUs.  But it isn't nice for the case where a
user wants support for their specific processor and no other.  I have a
P-II, why include code that only works on K7 or P-III?  The embedded
people, I think, would find such a change useful too.

The only problem with an alpha-like configuration is that Mandrake
cannot select a minimum CPU level of support anymore... I guess that
could be solved by an "advanced" sub-menu, similar to that which is
found in drivers/video/Config.in, which allows fine-grained Y/N
selections of CPU support.

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."

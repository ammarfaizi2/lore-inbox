Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbRERTWP>; Fri, 18 May 2001 15:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261462AbRERTWG>; Fri, 18 May 2001 15:22:06 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:56204 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261459AbRERTVy>; Fri, 18 May 2001 15:21:54 -0400
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC, AMD-K6/2 -mcpu=586...
In-Reply-To: <m2u22ibww6.fsf@sympatico.ca> <m2d796twqe.fsf@sympatico.ca> <20010518203446.A1066@werewolf.able.es> <m2eltm335t.fsf@sympatico.ca>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 18 May 2001 15:20:26 -0400
In-Reply-To: Bill Pringlemeir's message of "18 May 2001 14:47:26 -0400"
Message-ID: <m23da2mpl1.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> "JAM" == J A Magallon <jamagallon@able.es> writes:

 JAM> That is not the problem. The problem is that the registers have
 JAM> to lay in a defined way, transcribed to a C struct, and that
 JAM> pgcc lays badly that struct.

 WJP> Yes, I understand that.  I was showing a way to find the value
 WJP> of padding needed to align the register store in the structure.
 WJP> Perhaps I should have shown a mod to asm/processor.h,
[snip]
 WJP> I was describing a way to make things independent of the
 WJP> compiler layout of the structs.  However, this complicates the
 WJP> build process, and people might not like the padding due to
 WJP> cache alignment details.

Sorry,  they would obviously declare it as such if the kernel developers
wanted to.

        /* floating point info */
        unsigned char fpAlign[0] __attribute__ ((aligned (16)));
	union i387_union	i387;

This is a much simpler way of achieving what I was trying to explain
previously.  I think that this syntax has been in the GCC extensions
for some time.

regards,
Bill Pringlemeir.



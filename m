Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312783AbSDFUSy>; Sat, 6 Apr 2002 15:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312790AbSDFUSx>; Sat, 6 Apr 2002 15:18:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44292 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312783AbSDFUSw>; Sat, 6 Apr 2002 15:18:52 -0500
Date: Sat, 6 Apr 2002 12:18:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Brian Gerst <bgerst@didntduck.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up x86 interrupt entry code
In-Reply-To: <1018123940.899.104.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0204061216570.26740-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Apr 2002, Robert Love wrote:
> 
> You removed GET_THREAD_INFO and there does not seem to be a
> replacement.  Is there some assurance *thread_info is now pointed to by
> %ebx here?

It seems to be always loaded by the common interrupt code (and %ebx is a 
call-saved register, so calling the interrupt handlers and returning 
doesn't clobber it).

But testing it may be a good idea ;^p

		Linus


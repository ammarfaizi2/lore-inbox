Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287098AbSABW0Q>; Wed, 2 Jan 2002 17:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287051AbSABW0F>; Wed, 2 Jan 2002 17:26:05 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:11004 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S287089AbSABWZg>; Wed, 2 Jan 2002 17:25:36 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <DC4407B5751@vcnet.vc.cvut.cz> 
In-Reply-To: <DC4407B5751@vcnet.vc.cvut.cz> 
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Paul Koning <pkoning@equallogic.com>, trini@kernel.crashing.org,
        velco@fadata.bg, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Jan 2002 22:24:14 +0000
Message-ID: <21991.1010010254@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


VANDROVE@vc.cvut.cz said:
> (and for CONSTANT < 5 it of course generated correct code to fill dst
> with string contents; and yes, I know that code will sigsegv on run
> because of dst is not initialized - but it should die at runtime, not
> at compile time). 

An ICE, while it's not quite what was expected and it'll probably get fixed,
is nonetheless a perfectly valid implementation of 'undefined behaviour'.
You should count yourself lucky that the compiler didn't beat you up, sleep
with your mother, and/or start WW III.

Contributors to this thread who want to write a kernel in some C-like
language other than C probably ought to start by writing their own compiler,
rather than complaining about gcc. (I won't suggest starting with a language
spec, as the people in question don't really seem to be interested in
those.)

That or implement DWIM for gcc, I suppose...

Can we fix the broken code and stop being silly now, please?

--
dwmw2



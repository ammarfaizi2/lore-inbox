Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSFKKgl>; Tue, 11 Jun 2002 06:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316995AbSFKKgk>; Tue, 11 Jun 2002 06:36:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29199 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316996AbSFKKgf>; Tue, 11 Jun 2002 06:36:35 -0400
Date: Tue, 11 Jun 2002 11:36:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020611113629.A3081@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048CFD.2090201@evision-ventures.com> <20020611004000.GH5202@kroah.com> <3D0599AE.7080809@evision-ventures.com> <20020611092637.C1346@flint.arm.linux.org.uk> <3D05B61F.4010609@evision-ventures.com> <20020611100634.D1346@flint.arm.linux.org.uk> <3D05BE5B.1000705@evision-ventures.com> <20020611102859.F1346@flint.arm.linux.org.uk> <3D05C61B.1090809@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 11:42:51AM +0200, Martin Dalecki wrote:
> Well I surely understand what a pointer to the local variable set is.
> I know pascal and gdb well enough :-). However what I may have
> missed is that ARM is using some other task switch mechanism.
> I would be courious to see what it is?

Frame pointer - used to reference the function return state, and function
arguments.  Optional.

Stack pointer - used to reference the function local variables.  In the
absence of the frame pointer, this is also used to reference the function
return state and the function arguments.

As you can see, it has nothing to do with task switch mechanisms.

I suggest you revise your "pascal and gdb" and "task switch mechanism"
knowledge.  I don't believe ARM is special in doing the above.  In fact,
the above is probably very common indeed.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


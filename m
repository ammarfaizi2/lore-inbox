Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279407AbRKFM5q>; Tue, 6 Nov 2001 07:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279305AbRKFM5m>; Tue, 6 Nov 2001 07:57:42 -0500
Received: from [195.63.194.11] ([195.63.194.11]:48145 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S279156AbRKFM5C>; Tue, 6 Nov 2001 07:57:02 -0500
Message-ID: <3BE7EA87.7A1A23CA@evision-ventures.com>
Date: Tue, 06 Nov 2001 14:49:59 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Tim Jansen <tim@tjansen.de>, andersen@codepoet.org,
        Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <Pine.GSO.4.21.0111051836490.27086-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Tue, 6 Nov 2001, Tim Jansen wrote:
> 
> > But how can the user know this without looking into the kernel? Compare it to
> > /proc/mounts. Proc mounts escapes spaces and other special characters in
> > strings with an octal encoding (so spaces are replaced by '\040').
> 
> Ah, yes - the horrible /proc/mounts.  Check that code in 2.4.13-ac8, will
> you?
> 
> Yes, current procfs sucks.  We got a decent infrastructure that allows
> to write that code easily.  Again, see -ac8 and watch fs/namespace.c
> code dealing with /proc/mounts.
> 
> No need to play silly buggers with "one value per file" (and invite the
> Elder Ones with applications trying to use getdents()).  Sigh...

Getdents() can be removed since 2.0 times. I never noticed *any*
application
actually using it.

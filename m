Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281429AbRKEXld>; Mon, 5 Nov 2001 18:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281435AbRKEXlX>; Mon, 5 Nov 2001 18:41:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29867 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281429AbRKEXlI>;
	Mon, 5 Nov 2001 18:41:08 -0500
Date: Mon, 5 Nov 2001 18:41:07 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tim Jansen <tim@tjansen.de>
cc: andersen@codepoet.org, Ben Greear <greearb@candelatech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <160tEV-20u3KSC@fmrl04.sul.t-online.com>
Message-ID: <Pine.GSO.4.21.0111051836490.27086-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Tim Jansen wrote:

> But how can the user know this without looking into the kernel? Compare it to 
> /proc/mounts. Proc mounts escapes spaces and other special characters in 
> strings with an octal encoding (so spaces are replaced by '\040'). 

Ah, yes - the horrible /proc/mounts.  Check that code in 2.4.13-ac8, will
you?

Yes, current procfs sucks.  We got a decent infrastructure that allows
to write that code easily.  Again, see -ac8 and watch fs/namespace.c
code dealing with /proc/mounts.

No need to play silly buggers with "one value per file" (and invite the
Elder Ones with applications trying to use getdents()).  Sigh...


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRKSOqx>; Mon, 19 Nov 2001 09:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276894AbRKSOqe>; Mon, 19 Nov 2001 09:46:34 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:63215 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273305AbRKSOqV>;
	Mon, 19 Nov 2001 09:46:21 -0500
Date: Mon, 19 Nov 2001 09:46:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <01111916225301.00817@nemo>
Message-ID: <Pine.GSO.4.21.0111190927100.17210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Nov 2001, vda wrote:

> Everytime I do 'chmod -R a+rX dir' and wonder are there
> any executables which I don't want to become world executable,
> I think "Whatta hell with this x bit meaning 'can browse'
> for dirs?! Who was that clever guy who invented that? Grrrr"
> 
> Isn't r sufficient? Can we deprecate x for dirs?
> I.e. make it a mirror of r: you set r, you see x set,
> you clear r, you see x cleared, set/clear x = nop?

See UNIX FAQ.  Ability to read != ability to lookup.

Trivial example: you have a directory with a bunch of subdirectories.
You want owners of subdirectories to see them.  You don't want them
to _know_ about other subdirectories.

--
BUGS
     There's no perm option for the naughty bits.
							BSD chmod(1)


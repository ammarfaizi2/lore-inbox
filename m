Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbSJEFEa>; Sat, 5 Oct 2002 01:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSJEFEa>; Sat, 5 Oct 2002 01:04:30 -0400
Received: from ns.suse.de ([213.95.15.193]:5898 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262045AbSJEFEa>;
	Sat, 5 Oct 2002 01:04:30 -0400
Date: Sat, 5 Oct 2002 07:10:04 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Why does x86_64 support a SuSE-specific ioctl?
Message-ID: <20021005071003.A15345@wotan.suse.de>
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de.suse.lists.linux.kernel> <p73adltqz9g.fsf@oldwotan.suse.de> <3D9E72C8.1070203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9E72C8.1070203@pobox.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems like a good idea to -not- add this ioctl, because
> * if 2.4.x and 2.5.x don't have it, there obviously isn't a huge need 
> for it, so why add one more ioctl we will have to maintain binary 
> compatibility for

The 'blogd' daemon requires it. There is also no other good way to do this
(parsing /proc/cmdline is not an option because /proc may not exist or 
note be mounted)

> * "real dev" doesn't necessary have meaning in all contexts, IIRC

Can you give an example on when it doesn't have meaning ?

> * viro might have a cow at the use of kdev_t_to_nr...  is that required 
> for compatibility with some existing apps?  It seems like you want to 
> _decompose_ a number into major/minor, to be an interface that 
> withstands the test of time

It withstands the test of time as well as stat(2) or the loop ioctls.

-Andi

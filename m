Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137001AbREKAIC>; Thu, 10 May 2001 20:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137002AbREKAHx>; Thu, 10 May 2001 20:07:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29641 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S137001AbREKAHj>;
	Thu, 10 May 2001 20:07:39 -0400
Date: Thu, 10 May 2001 20:07:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jonathan Lundell <jlundell@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Not a typewriter
In-Reply-To: <p0510030cb720d6cb4ecd@[10.128.7.49]>
Message-ID: <Pine.GSO.4.21.0105102001000.3943-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 May 2001, Jonathan Lundell wrote:

> ENOTTY is used by several non-serial devices (or file systems) to 
> object to an unrecognized ioctl command. There's also ENOIOCTLCMD 
> (apparently supposed to be a non-user errno, but i don't see where it 
> gets changed to something else) and EINVAL. I'm not sure what the 
> rationale is for choosing among them; perhaps someone would elucidate?

ENOIOCTLCMD is something I've never met in the kernel. Normal reaction
to unrecognized ioctl() is ENOTTY, for a lot of reasons, starting with
the fact that ioctls are last-ditch API to be used when you just can't
think of better one and historically TTY had the earliest (and largest)
infestation. IOW, "not a tty" used to mean "WTF are you using ioctls here?"
OTOH, EINVAL is a catch-all thing for "something is wrong with arguments".


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314215AbSD0TLA>; Sat, 27 Apr 2002 15:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSD0TK7>; Sat, 27 Apr 2002 15:10:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33375 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314215AbSD0TK7>; Sat, 27 Apr 2002 15:10:59 -0400
To: Padraig Brady <padraig@antefacto.com>
Cc: ebuddington@wesleyan.edu, linux-kernel@vger.kernel.org
Subject: Re: Dissociating process from bin's filesystem
In-Reply-To: <20020424224714.B19073@ma-northadams1b-46.bur.adelphia.net>
	<3CC7EBC3.6030707@antefacto.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Apr 2002 13:03:11 -0600
Message-ID: <m1znzp0xsg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig Brady <padraig@antefacto.com> writes:

> I'm think this is not possible at the moment.
> 
> The file of the executing process is in use as the backing store for
> one or more live virtual memory areas, so changing it could
> corrupt the processes using those areas. Hence you can't umount.
> 
> Now the Mach kernel has a MAP_COPY flag to the mmap system call
> which would do what you want, but this is mucho complex/messy,
> so don't hold your breath for a linux implementation.
> 
> A related note on shared libraries is you don't get the
> "text file busy" message if you  update them while they're in use,
> like you do for executable files. The reason is MAP_DENYWRITE
> is ignored for security reasons. I think Eric Biederman has
> a workaround though?

I played with it but could find nothing better than.
chmod a-w file
And it wasn't terribly important personally so I dropped it.

Eric


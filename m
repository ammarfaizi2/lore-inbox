Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261497AbSJPV6U>; Wed, 16 Oct 2002 17:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261499AbSJPV6T>; Wed, 16 Oct 2002 17:58:19 -0400
Received: from tantale.fifi.org ([216.27.190.146]:22406 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S261497AbSJPV6S>;
	Wed, 16 Oct 2002 17:58:18 -0400
To: daw@mozart.cs.berkeley.edu (David Wagner)
Cc: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org
Subject: Re: can chroot be made safe for non-root?
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
	<87n0pevq5r.fsf@ceramic.fifi.org>
	<aokl28$955$2@abraham.cs.berkeley.edu>
From: Philippe Troin <phil@fifi.org>
Date: 16 Oct 2002 15:04:11 -0700
In-Reply-To: <aokl28$955$2@abraham.cs.berkeley.edu>
Message-ID: <87elaqrqg4.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daw@mozart.cs.berkeley.edu (David Wagner) writes:

> Philippe Troin  wrote:
> >Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net> writes:
> >> Would it be reasonable to allow non-root processes to chroot(), if the
> >> chroot syscall also changed the cwd for non-root processes?
> >
> >No.
> >
> >  fd = open("/", O_RDONLY);
> >  chroot("/tmp");
> >  fchdir(fd);
> >
> >and you're out of the chroot.
> 
> Irrelevant.  If a process *wants* to voluntarily sandbox itself, it can
> close all open file descriptors before sandboxing.

You missed the point.

If the process can be forced to run the above (possibly via a stack
overflow), then it is out of the chroot.

Phil.

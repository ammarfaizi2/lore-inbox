Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbSJIPI0>; Wed, 9 Oct 2002 11:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbSJIPI0>; Wed, 9 Oct 2002 11:08:26 -0400
Received: from borg.org ([208.218.135.231]:24049 "HELO borg.org")
	by vger.kernel.org with SMTP id <S261801AbSJIPIY>;
	Wed, 9 Oct 2002 11:08:24 -0400
Date: Wed, 9 Oct 2002 11:14:07 -0400
From: Kent Borg <kentborg@borg.org>
To: Erik Andersen <andersen@codepoet.org>, Ben Collins <bcollins@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Loading init and ld.so.1 for Coldfire V4e
Message-ID: <20021009111407.B17419@borg.org>
References: <20021008155415.D9391@borg.org> <20021008214044.GA22488@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008214044.GA22488@codepoet.org>; from andersen@codepoet.org on Tue, Oct 08, 2002 at 03:40:44PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In response to my question about how ld.so.1 is supposed to get an elf
file up and running Ben Collins and Erik Andersen suggested I write a
simple statically linked program.  Thanks for your help.  (My boss had
suggested the same thing earlier but I didn't listen to him, the
kernel list I listened to.)

Alas, it doesn't simplify matters.  I wrote a tivial program (all it
does is a link instruction to make an empty stack frame, two moves, an
unlink to remove the empty stack frame, and a return--only 5
instructions long) but it is still an elf file.  And, following
through the code, the kernel still wants to load ld.so.1, it seems to
interpret the elf (Linux can run different kinds of executables,
remember).  And in the process something gets messed up.

So I am back to trying to figure out what is going wrong with loading
init and ld.so.1.  I am suspicious that do_mmap_pgoff() calls are not
all happening right and will be comparing them with what mappings.
But I wish I knew more about what ld.so.1 does...


-kb, the Kent who is in new territory in about three ways.


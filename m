Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbSKZOsa>; Tue, 26 Nov 2002 09:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266316AbSKZOsa>; Tue, 26 Nov 2002 09:48:30 -0500
Received: from jrt.me.vt.edu ([128.173.188.212]:18052 "HELO jrt.me.vt.edu")
	by vger.kernel.org with SMTP id <S266224AbSKZOs3>;
	Tue, 26 Nov 2002 09:48:29 -0500
Date: Tue, 26 Nov 2002 10:55:10 -0500 (EST)
From: Clemmitt Sigler <siglercm@jrt.me.vt.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Alan Cox <Alan.Cox@linux.org>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
In-Reply-To: <20021126024739.GA11903@think.thunk.org>
Message-ID: <Pine.LNX.4.33L2.0211261042290.2368-100000@jrt.me.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Nov 2002, Theodore Ts'o wrote:
> Well, no; it could also be that some kind of filesystem corruption
> either made the directories disappear, or caused e2fsck to believe
> that the files needed to be removed or moved into lost+found.  There
> are a million possible explanations, including a bug in a device
> driver, the VM layer, or just pure coincidence.

I got no indication that anything was moved into lost+found similar
to what I've gotten on test systems where the filesystem was
intentionally crashed.  No human y/n intervention required this time :^(
it just trashed things and then went on its merry way, and failed to
boot because things were messed up in /etc (and perhaps other places
in the / partition).

> Without some clear indication of what e2fsck actually printed we'd
> only be speculating.
> Can you can duplicate the problem?

The e2fsck run seemed to me to go normally.  It reported that it
optimized some directories, but this has happened on other auto-fscks
of my ext3 filesystems without corruption under earlier kernels.  (This
is the first corruption I've seen in many, many years.)  But I didn't
capture the messages :^( and they don't get written into
/var/log/messages (that I could find).

When 2.4.20 final comes out, I'll set up a mirror system and try to
duplicate the problem.  I'll be sure to check lost+found, too.
(The system this happened on is my production workstation and isn't
suitable for testing.)  Thanks.

					Clemmitt Sigler


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129665AbRBUMjD>; Wed, 21 Feb 2001 07:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbRBUMiw>; Wed, 21 Feb 2001 07:38:52 -0500
Received: from fe5.rdc-kc.rr.com ([24.94.163.52]:30992 "EHLO mail5.kc.rr.com")
	by vger.kernel.org with ESMTP id <S129665AbRBUMii>;
	Wed, 21 Feb 2001 07:38:38 -0500
To: subterfugue-announce@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] SUBTERFUGUE 0.2
From: Mike Coleman <mkc@mathdogs.com>
Date: 21 Feb 2001 06:38:35 -0600
In-Reply-To: mkc@users.sourceforge.net's message of "Mon, 30 Oct 2000 04:52:53 -0600 (CST)"
Message-ID: <87lmr043ec.fsf@mathdogs.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SUBTERFUGUE 0.2 is available.  It's been updated to work with the new 2.4
kernel and also includes a few other bug fixes and improvements.  It's
available in source or Debian package form.

As always, feedback is welcome.
--Mike


==============================================================================
README:

SUBTERFUGUE is a framework for observing and playing with the reality of
software; it's a foundation for building tools to do tracing, sandboxing, and
many other things.  You could think of it as "strace meets expect."

Here's a short (real) "screenshot" which hints at one of its possible uses:

    # sf --trick=SimplePathSandbox:"read=['/'];write=['/dev/tty']" bash
    # id
    uid=0(root) gid=0(root) groups=0(root)
    # rm -f /etc/passwd
    write deny (unlink): '/etc/passwd'
    rm: cannot unlink `/etc/passwd': Permission denied

[Translation: Run 'bash' in a sandbox (restricted environment) so that it and
all of the processes it creates can read all files (everything under '/') but
can only write '/dev/tty'.  All system calls that read or write to the
filesystem are checked, and the attempt to unlink '/etc/passwd' is
disallowed.]

Disclaimer: SUBTERFUGUE is still fairly alpha.  If you run it on a system that
matters and something breaks, you get to keep both pieces.  Especially avoid
programs where a loss of state might be disastrous (e.g., fetchmail).

See 'http://subterfugue.org' and the sf(1) man page for more info.  See the
file 'NEWS' in the distribution for info on the latest release.


==============================================================================
NEWS:

Version 0.2 ("tiger")

* Fixes to make SUBTERFUGUE work again with the 2.4 kernel.  (new system
  calls, slightly different wait behaviors, etc)

* Added 'now' and 'delta' flags to TimeWarp trick.  Experience the future and
  the past!

* New 'herekitty' script to amuse your cat!  (Dan Egnor's cool idea)

* FixFlash trick fixes a problem with the Macromedia Flash plugin that causes
  Netscape to hang when Flash tries to use /dev/dsp and it's in use.

* The TRACESYSGOOD patch is included in the kernel as of 2.4.0-test10, so
  revert to disabling the "wait channel hack" by default.  (Only vanilla
  2.3.99 through 2.4.0-test9 need it now.)

* Added '--nowall', which allows sf to run somewhat in a degenerate way under
  linux 2.2.

* Disable python '-O' flag by default, as it turns off assertion checking,
  which is still extremely useful at this point.


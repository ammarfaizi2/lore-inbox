Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUBVUpp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUBVUpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:45:45 -0500
Received: from mail.shareable.org ([81.29.64.88]:9346 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261746AbUBVUpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:45:44 -0500
Date: Sun, 22 Feb 2004 20:45:41 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 filenames
Message-ID: <20040222204541.GA26793@mail.shareable.org>
References: <18de01c3f93f$dc6d91d0$b5ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18de01c3f93f$dc6d91d0$b5ee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond wrote:
> Consider
> converting all your ASCII filenames to UTF-16.  Let everyone share the
> short-term pain for the long-term gain.  When you get everyone to agree on
> UTF-16, it will be ugly, but it will be equal for everyone.

UTF-8 is the only sane universal encoding in unix.

UTF-16 is not an option; it's not POSIX compatible, it won't work with
the assumptions made by _all_ unix programs that deal with paths, and
in it won't by useful at all in a unix environment without rewriting
*every single program*.

Also, what would be the point?  UTF-16 as an encoding is about as
complex as UTF-8 (charcters in UTF-16 are 2-4 bytes long depending on
the character), so it's equally hard to program with correctly.

> By the way, another subthread mentioned that stty puts some stuff in the
> kernel that could be done in user space.  In Unix systems the same is true
> for IMEs, stty options specify the encoding of the output of an IME (e.g.
> EUC-JP or SJIS, which then gets forwarded as input to shells, applications,
> etc.), and whether a single backspace (or whatever character deletion
> character) deletes an entire input character instead of just deleting a
> single byte, etc.  I keep forgetting to see if Linux has the same stty
> options.  I haven't needed to set them with stty because if I need to use a
> different locale then I just open a new terminal emulator window using that
> locale.

Do you have a list or description of the specific stty options that
are used?

-- Jamie

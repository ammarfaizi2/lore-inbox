Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUAEIN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 03:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbUAEIN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 03:13:26 -0500
Received: from findaloan.ca ([66.11.177.6]:54968 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S265898AbUAEINP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 03:13:15 -0500
Date: Sun, 4 Jan 2004 20:47:55 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jeremy Maitin-Shepard <jbms@attbi.com>
Cc: linux-kernel@vger.kernel.org
Subject: st_dev:st_ino (was: Re: udev and devfs - The final word)
Message-ID: <20040105014755.GB24410@mark.mielke.cc>
Mail-Followup-To: Jeremy Maitin-Shepard <jbms@attbi.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <200401042335.i04NZqQZ029910@turing-police.cc.vt.edu> <87k747w4ow.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k747w4ow.fsf@jbms.ath.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 08:43:27PM -0500, Jeremy Maitin-Shepard wrote:
> Unfortunately, programs such as tar depend on inode numbers of distinct
> files being distinct even when the file is not open over a period of
> several minutes/seconds.  This is needed to avoid dumping hard links
> more than once.  Furthermore, there is no efficient way to write
> programs such as tar without depending on this capability.  Thus, if
> st_ino cannot be used reliably for this purpose, it would be useful for
> there to be a system call for retrieving a true
> unique-within-the-filesystem identifier for the file.

We already have that: st_nlink

I think you mean a system call that would allow you to be certain that
two file descriptors refer to the same file. Then, any files with
st_nlink >= 2 would have to use the system call to match them up.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268723AbUILNoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268723AbUILNoP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 09:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268724AbUILNoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 09:44:15 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:33708 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S268723AbUILNoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 09:44:08 -0400
Date: Sun, 12 Sep 2004 17:44:12 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: Chris Siebenmann <cks@utcc.utoronto.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <41446ECC.nailNA21Y93K@pluto.uni-freiburg.de>
References: <04Sep10.170341edt.41989@gpu.utcc.utoronto.ca>
In-Reply-To: <04Sep10.170341edt.41989@gpu.utcc.utoronto.ca>
User-Agent: nail 11.7pre 9/10/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Siebenmann <cks@utcc.utoronto.ca> wrote:

>  I believe that this approach clashes violently with Hans Reiser's
> goals for reiser4, which I believe plans to have every regular file
> also have a stream component (for through-filesystem access to the
> stat data, if nothing else). Many of the other visions on exhibit in
> the thread seem to be almost as expansive, envisioning such streamed
> files used widely for various sorts of content annotation in places
> such as GNOME/KDE.

Although some individuals did tell about their 'visions' in this thread,
there were serious arguments against their use for anything else except
specialities like CIFS support. Many people do just not care about most
of the 'visions'.

>  I believe Linus Torvald's 'openat()' approach would maintain POSIX
> compatability, because it doesn't change the POSIX-visible namespace.

But it has the serious problem that handling a S_IFREG file in just the
usual manner will lead to silent data loss. Even with all POSIX issues
left aside, this seems hardly acceptable to me.

> [This is a separate issue to whether it would work better this way,
>  or whether it can be POSIX compliant without this. Hans Reiser at least
>  seems to not care very much about POSIX compliance for things like this,
>  so this sort of argument is unlikely to make him change his activities.]

As long as POSIX is only violated by some patch, people can ignore this
problem by just not applying it. Such will be possible even if Reiser4 is
integrated in the future; lack of POSIX conformance for FAT filesystems is
also not much of an issue.

The interesting point is that future VFS changes do not lead to POSIX
violations.

	Gunnar

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283603AbRL1A3e>; Thu, 27 Dec 2001 19:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283618AbRL1A3Y>; Thu, 27 Dec 2001 19:29:24 -0500
Received: from bcboy-linux.cisco.com ([171.71.68.225]:22796 "EHLO
	bcboy-linux.cisco.com") by vger.kernel.org with ESMTP
	id <S283603AbRL1A3T>; Thu, 27 Dec 2001 19:29:19 -0500
Date: Thu, 27 Dec 2001 16:28:41 -0800
From: Brian Craft <bcboy@thecraftstudio.com>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pasting arbitrary input to consoles
Message-ID: <20011227162841.A20931@bcboy-linux.cisco.com>
In-Reply-To: <20011227141759.A19460@bcboy-linux.cisco.com> <20011227155157.L12868@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011227155157.L12868@lynx.no>; from adilger@turbolabs.com on Thu, Dec 27, 2001 at 03:51:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Dec 27, 2001 at 03:51:57PM -0700, Andreas Dilger wrote:
> Well, you could also make the voice-aware shell as the default shell for
> a given user

Interesting idea, though you'd need to auto login one of the consoles (since
the shell won't be up at the login prompt).

> For X you could also make the voice recognition system an input method

We're currently using the XTest extension, which works well. There are a number
of techniques you can use for X.

I just wrote a proof-of-concept for a truly hideous console solution:

    o Read the first line of /dev/vcs0
    o Write the to-be-pasted text to /dev/vcs0
    o Select the text via ioctl on /dev/tty0
    o Restore the first line of /dev/vcs0
    o Paste via ioctl on /dev/tty0

Hehehe. It works. And it's good just for the gross-out value.

Thanks,
b.c.

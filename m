Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132343AbQLIWfi>; Sat, 9 Dec 2000 17:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132344AbQLIWf1>; Sat, 9 Dec 2000 17:35:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30982 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132343AbQLIWfR>; Sat, 9 Dec 2000 17:35:17 -0500
Date: Sat, 9 Dec 2000 23:06:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swapoff weird
Message-ID: <20001209230615.C5542@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20001209222427.A1542@bug.ucw.cz> <Pine.LNX.4.21.0012091941170.19389-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0012091941170.19389-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sat, Dec 09, 2000 at 07:41:54PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 9 Dec 2000, Pavel Machek wrote:
> 
> > It is possible to remove swapfile in use. Great, but how do you
> > swap off then? Who is to blame?
> 
> As usual, root is to blame ;)

I do not agree. It is too easy to get to situation like this.

> > root@bug:~# swapoff /tmp/swap
> > swapoff: /tmp/swap: No such file or directory
> > root@bug:~# > /tmp/swap
> > root@bug:~# swapoff /tmp/swap
> > swapoff: /tmp/swap: Invalid argument
> > root@bug:~#
> 
> Don't let your automatic /tmp cleaners remove the swap
> file ;)
> 
> > How do I get out of this bad situation?
> 
> Reboot.

I'm afraid even reboot will not work.

I can't swapoff.  Therefore filesystem is busy (it must be -- kernel
might be writing to file on it!). And no way to get out of that. 
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270844AbRHNUvx>; Tue, 14 Aug 2001 16:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270843AbRHNUvn>; Tue, 14 Aug 2001 16:51:43 -0400
Received: from shad0w.dial.nildram.co.uk ([195.112.18.51]:57097 "EHLO
	mail.shad0w.org.uk") by vger.kernel.org with ESMTP
	id <S270845AbRHNUvc>; Tue, 14 Aug 2001 16:51:32 -0400
Date: Tue, 14 Aug 2001 21:54:09 +0100 (BST)
From: Chris Crowther <chrisc@shad0w.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CDP handler for linux
In-Reply-To: <E15Wkcc-0001r2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108142137300.3810-100000@monolith.shad0w.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Alan Cox wrote:

> It looks well written. I do have only one question, other than "because
> I wanted to learn how to do it this way", is there a reason for putting
> this into kernel space not a daemon ?

	Hmm, looking at CDP there isn't really any reason to put it in
userspace either, it doesn't need to be configured, it doesn't pass
anything the way of the user, except by way of the output of (currently)
/proc/net/cdp_neighbors, and it doesn't need the user to interact with it
either - it just sits there, collecting and sending information.  The only
thing you would really need in userspace, would be tools to read
information from the cdp handler if you wanted to do more than just look
at the neighbor summary.  I can't see any real advantages of running it as
a daemon as opposed to a kernel component.

	This said, if the consesus is that it belongs in userspace, I
shall set about porting the code over to a dameon and possibly maintaing
the kernel patch as a secondary "hobby project".

-- 
Chris "_Shad0w_" Crowther
chrisc@shad0w.org.uk
http://www.shad0w.org.uk/


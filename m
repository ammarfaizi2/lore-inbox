Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVHTRae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVHTRae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 13:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVHTRae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 13:30:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932588AbVHTRae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 13:30:34 -0400
Date: Sat, 20 Aug 2005 10:30:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: open("foo", 3)
In-Reply-To: <E1E6WCz-0005ym-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.58.0508200958260.3317@g5.osdl.org>
References: <E1E6WCz-0005ym-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Aug 2005, Miklos Szeredi wrote:
> 
> My question is: is this deliberate or accidental?  Wouldn't it be more
> logical to not require any permission to open such file?  Or is there
> some security concern with that?

It's deliberate but historical. It's been a long time since I worked on
it, but it was meant for "special opens".

I _think_ it was used for things like "open block device without media
check" etc (we use O_NONBLOCK for that now), and it was used for directory
opens before we had O_DIRECTORY. (It's literally been years, so my 
recollection may be bogus).

I don't think anything uses it any more, and it should probably be 
deprecated rather than extended upon.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTE0BLx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbTE0BLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:11:52 -0400
Received: from imap.gmx.net ([213.165.65.60]:24737 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262439AbTE0BLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:11:22 -0400
Message-ID: <3ED2BE4D.4080005@gmx.net>
Date: Tue, 27 May 2003 03:24:29 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net,
       Dan Carpenter <d_carpenter@sbcglobal.net>
Subject: Re: [2.5] [Cool stuff] "checking" mode for kernel builds
References: <Pine.LNX.4.44.0305261728520.15826-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305261728520.15826-100000@home.transmeta.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Linus: Sorry that your e-mail to me bounced. Was a provider screwup,
should be fixed now.]
[CC:ed kerneljanitors, who might be interested using it.
 CC:ed Dan Carpenter, who mantains a set of tools similar to sparse, but
as a gcc patch at http://kbugs.org ]

Linus Torvalds wrote:
> Well, I guess I can just tell people about it. It's unfinished enough that
> I'm a bit embarrassed about some of it, but I've gotten the permission
> from Transmeta to make it open source, and it's actually been available
> for some time on "bk://kernel.bkbits.net/torvalds/sparse". I just didn't 
> tell about it in public (although a few people have known about it).
> 
> Be gentle with it. It does many things wrong, including (but limited 
> to) enums, but it does a lot of things right too.

Playing with it right now.

> The biggest problem (apart from the things it does wrong) is that some
> parts of the kenel re-use the same structure to hold both user- and kernel
> pointers. That's a big no-no for the static semantic parser, since it's 
> literally a _static_ type-checker, and doesn't know about dynamic 
> differences. 
> 
> The main offender is the networking layer that sometimes keeps user
> pointers and sometimes kernel pointers in a "struct iovec". David has
> promised to look into this, and seemed confident that he can fix it 
> easily.
> 
> Most people who have used the tool actually like how it forces you to make 
> it very _explicit_ whether you're using a user pointer or not. But I have 
> to admit that I've grown tired of trying to look at all the uses and 
> making sure which sparse warnings are valid and which aren't.

Dan? IIRC you have tools to tackle this issue in a distributed manner.


Regards,
Carl-Daniel


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314381AbSEMTSw>; Mon, 13 May 2002 15:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314383AbSEMTSv>; Mon, 13 May 2002 15:18:51 -0400
Received: from [195.39.17.254] ([195.39.17.254]:32918 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314381AbSEMTSv>;
	Mon, 13 May 2002 15:18:51 -0400
Date: Mon, 13 May 2002 12:55:21 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dax Kelson <dax@gurulabs.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@transmeta.com" <torvalds@transmeta.com>,
        "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
        "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Subject: Re: [RFC] Making capabilites useful with legacy apps
Message-ID: <20020513125519.A37@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0205082029060.14553-100000@sphinx.mythic-beasts.com> <Pine.LNX.4.44.0205081403120.10496-100000@mooru.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In attempt to make capabilites more useful before the filesytem support 
> arrives, I would like to "wrap" non-capabilities aware apps.
> 
> For example:
> 
> # capwrap --user nobody --grp nobody --cap CAP_NET_BIND_SERVICE nc -l -p 80

That looks pretty nice...

> This wrapper[1] (that would increase security) won't work with the current 
> kernel though, because at step 6, all capabilities are cleared.

This should be fixed, then.
									Pavel
PS: you could ptrace attach yourself, fork and exec on root, and then force
newly exec-ed app to give up id... But that's ugly and complicated hack.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


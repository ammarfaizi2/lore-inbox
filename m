Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVDIBZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVDIBZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVDIBZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:25:08 -0400
Received: from adsl-69-233-54-142.dsl.pltn13.pacbell.net ([69.233.54.142]:5385
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S261247AbVDIBYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:24:17 -0400
Message-ID: <42572E8E.3000200@tupshin.com>
Date: Fri, 08 Apr 2005 18:23:26 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <1112858331.6924.17.camel@localhost.localdomain> <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org> <Pine.LNX.4.61.0504072318010.15339@scrub.home> <425717CB.6020405@tupshin.com> <Pine.LNX.4.61.0504090242531.15339@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0504090242531.15339@scrub.home>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:

>
>
>Please show me how you would do a binary search with arch.
>
>I don't really like the arch model, it's far too restrictive and it's 
>jumping through hoops to get to an acceptable speed.
>What I expect from a SCM is that it maintains both a version index of the 
>directory structure and a version index of the individual files. Arch 
>makes it especially painful to extract this data quickly. For the common 
>cases it throws disk space at the problem and does a lot of caching, but 
>there are still enough problems (e.g. annotate), which require scanning of 
>lots of tarballs.
>
>bye, Roman
>  
>
I'm not going to defend or attack arch since I haven't used it enough. I 
will say that darcs largely does suffer from the same problem that you 
describe since its fundamental unit of storage is individual patches 
(though it avoids the tarball issue). This is why David Roundy has 
indicated his intention of eventually having a per-file cache:
http://kerneltrap.org/mailarchive/1/message/24317/flat

You could then make the argument that if you have a per-file 
representation of the history, why do you also need/want a per-patch 
representation as the canonical format, but that's been argued plenty on 
both the darcs and arch mailing lists and probably isn't worth going 
into here.

-Tupshin

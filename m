Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVDIBDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVDIBDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVDIBDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:03:25 -0400
Received: from ds01.webmacher.de ([213.239.192.226]:61355 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261226AbVDIBCO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:02:14 -0400
In-Reply-To: <20050407074407.GA25194@vagabond>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050407074407.GA25194@vagabond>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f74102c2ddfe02b2d98d28e1a25a0634@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: Kernel SCM saga..
Date: Sat, 9 Apr 2005 03:01:29 +0200
To: Jan Hudec <bulb@ucw.cz>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-04-07, at 09:44, Jan Hudec wrote:
>
> I have looked at most systems currently available. I would suggest
> following for closer look on:
>
> 1) GNU Arch/Bazaar. They use the same archive format, simple, have the
>    concepts right. It may need some scripts or add ons. When Bazaar-NG
>    is ready, it will be able to read the GNU Arch/Bazaar archives so
>    switching should be easy.

Arch isn't a sound example of software design. Quite contrary to the 
random notes posted by it's author the following issues did strike me 
the time I did evaluate it:

The application (tla) claims to have "intuitive" command names. However
I didn't see that as given. Most of them where difficult to remember
and appeared to be just infantile. I stopped looking further after I 
saw:

tla my-id instead of: tla user-id or oeven tla set id ...

tla make-archive instead of tla init

tla my-default-archive john@dole.com--2005-VersionPatrol

No more "My Compuer" please...

Repository addressing requires you to use informally defined
very elaborated and typing error prone conventions:

mkdir ~/{archives}
tla make-archive john@dole.com--20005-VersionPatrol 
~/{archives}/2005-VersionPatrol

You notice the requirement for two commands to accomplish a single task 
already
well denoted by the second command? There is more of the same at quite 
a few places
when you try to use it. You notice the triple zero it didn't catch?

As an added bonus it relies on the applications named by accident
patch and diff and installed on the host in question as well as few 
other as well to
operate.

Better don't waste your time with looking at Arch. Stick with patches
you maintain by hand combined with some scripts containing a list of 
apply commands
and you should be still more productive then when using Arch.


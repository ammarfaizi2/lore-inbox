Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWIGTip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWIGTip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWIGTip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:38:45 -0400
Received: from quechua.inka.de ([193.197.184.2]:55734 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751424AbWIGTip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:38:45 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060907173449.GA24013@clipper.ens.fr>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1GLPhz-0001T9-00@calista.eckenfels.net>
Date: Thu, 07 Sep 2006 21:38:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20060907173449.GA24013@clipper.ens.fr> you wrote:
> They wouldn't have to be marked: capabilities are inherited by
> default, with my patch (as is the Unix tradition: euid=0 or {r,s}uid=0
> are preserved upon execve()), normal processes have CAP_FORK and just
> pass it on if you don't do something special to remove it.

The Problem with that is, that a program can be started with some priveldges
without knowing it. Traditional programs only check for uid=0 and in that
case refuse to do some things. A program might not expect to be able to do a
priveldged action with not being uid=0.

I do think those programs are broken, but it is a argument, why the
inheritance should be off by default (unless the euid is always 0 if any
root privelddge is enabled)

> Yes.  In general, processes have all "regular" capabilities, and they
> are inherited normally.

I like that, i think it was once called user capabilities. I wonder if we
need to make those distinctions at all.

BTW: some of the priveldges could also be avoided by adding access control
to some kernel objects. I really like the windows approach here, and it
would be possible to have the permissions bound to special files (which
would also allow ACLs). So for example instead of haing CAP_NET_ADMIN the
kernel could check "can the process open /dev/objects/netadmin for write".

Gruss
Bernd

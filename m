Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbSAPS0q>; Wed, 16 Jan 2002 13:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286215AbSAPS0i>; Wed, 16 Jan 2002 13:26:38 -0500
Received: from lsanca1-ar27-4-63-187-072.vz.dsl.gtei.net ([4.63.187.72]:10885
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S286220AbSAPS0V>; Wed, 16 Jan 2002 13:26:21 -0500
Date: Wed, 16 Jan 2002 10:26:11 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
In-Reply-To: <87vge2jjt1.fsf@tigram.bogus.local>
Message-ID: <Pine.LNX.4.33.0201161018460.1758-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 2002, Olaf Dietsche wrote:

> This sounds weird. Normally, named binds to port 53 and some high
> unprivileged port for replies from other DNS servers. Do you have some
> 'listen-on' and/or 'query-source' statements in your named.conf? If
> you do, just change permissions of /mnt/net/ipv4/bind/921 appropriately.

The port 53 bindings happen without problem.

BINDv9 has a lightweight resolver service which runs on port 921 - this is
not enabled by default, and when it is enabled, seems to start up later on
in the startup process.


Add the single line:
lwres {};
in your named.conf and it will be enabled.



> You may use accessfs and capabilities in parallel, of course. But
> currently, this is equivalent to "chown root/chmod u+x".

Taking capabilities away seems to break backwards compatibility.

And I'm not entirely sure it *is* equivalent to chown root/chmod u+x -
that is how /mnt/accessfs/net/ipv4/bind appeared and my named couldn't
bind to 921.

Ben

-- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Job Required in Los Angeles - Will do most things unix or IP for money.
http://www.hawaga.org.uk/resume/resume001.pdf





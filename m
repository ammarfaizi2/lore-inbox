Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUACUVG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 15:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUACUVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 15:21:06 -0500
Received: from mail.mediaways.net ([193.189.224.113]:37451 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S263088AbUACUVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 15:21:04 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Soeren Sonnenburg <kernel@nn7.de>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Message-Id: <1073161172.9851.260.camel@localhost>
Mime-Version: 1.0
Date: Sat, 03 Jan 2004 21:19:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-03 at 20:40, Mark Hahn wrote:
> > yeah, I think so... but as generating output in a shell is a very common
> > thing to do there should either be an option to turn that unwanted
> > behaviour off or to fix this issue...
> 
> has anyone said it's desired behavior?  you probably need to describe 
> your setup more.  for instance, is your X niced to negative?  are there
> some background processes which would be consuming cycles?

freshly booted system with X running at niceness 0 no other processes consume cpu cycles.

it is reproducable by creating any kind of output which reads from disk... so
i.e. a find ./ in my home directory takes sometimes like 30 minutes on
2.6 (100%cpu load) and sometimes 5 minutes (on 2.4 always 5 minutes
~40%load).

dmesg is another candidate... just doing cat <file> seems not to trigger
that problem.

As Willy Tarreau also oberves this very same weirdness - I now know the
problem is there and it is not specific to my setup.

Soeren.


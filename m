Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbTGAGJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 02:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbTGAGJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 02:09:48 -0400
Received: from angband.namesys.com ([212.16.7.85]:22765 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S266003AbTGAGIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 02:08:22 -0400
Date: Tue, 1 Jul 2003 10:22:42 +0400
From: Oleg Drokin <green@namesys.com>
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PTY DOS vulnerability?
Message-ID: <20030701062242.GA7998@namesys.com>
References: <200306301613.11711.fredrik@dolda2000.cjb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306301613.11711.fredrik@dolda2000.cjb.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Jun 30, 2003 at 04:18:36PM +0200, Fredrik Tolf wrote:
> Has someone considered PTYs as a possible attack vector for DOS 
> attacks? Correct me if I'm wrong, but cannot someone just open 
> all available PTYs on a console-less server and make everyone 
> unable to log in?

ability to login != availability of free ptys.

> I mean, what if eg. apache is hacked, and the first thing the 
> attacker does is to tie up all PTYs, so that noone can log in to 
> correct the situation while the attacker can go about his 
> business? Then the only possible solution would be to reboot the 
> server, which might very well not be desirable.

Nope.
slogin someuser@someserver "/bin/bash -i"
will let you in even if you do not have a single pty free. Try it.
If course job control won't work and other minor things are there,
but still this is enough to e.g kill apache and all of its children in your case.

> Shouldn't PTYs be a per-user resource limit?

This one is still interesting, though.

Bye,
    Oleg

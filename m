Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTDJWLV (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbTDJWK7 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:10:59 -0400
Received: from [195.39.17.254] ([195.39.17.254]:9220 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S264229AbTDJWJi (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:09:38 -0400
Date: Thu, 10 Apr 2003 20:37:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Fixes for ide-disk.c
Message-ID: <20030410183730.GB4293@zaurus.ucw.cz>
References: <1049527877.1865.17.camel@laptop-linux.cunninghams> <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk> <1049570711.3320.2.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049570711.3320.2.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Drive->blocked is a single bit field. Its not a counting lock. Either
> > we are blocked or not.
> 
> Okay. We need a different solution then, but the problem remains - the
> driver can get multiple, nexted calls to block and unblock. Can it
> become a counting lock?

Simplest fix seems to be make sure it only
reacts to one "suspending level" (suspend_save_state)
and that really should not be nested.
(If that nests, fix caller)
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...


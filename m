Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVK2Fs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVK2Fs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 00:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVK2Fs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 00:48:26 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:8206 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750769AbVK2FsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 00:48:25 -0500
Date: Tue, 29 Nov 2005 06:48:19 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Chris Boot <bootc@bootc.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] un petite hack: /proc/*/ctl
Message-ID: <20051129054819.GR11266@alpha.home.local>
References: <20051129002801.GA9785@mipter.zuzino.mipt.ru> <D6440692-33C3-45F0-9112-C22332ED7072@bootc.net> <20051129013354.GA17749@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129013354.GA17749@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 04:33:54AM +0300, Alexey Dobriyan wrote:
> On Tue, Nov 29, 2005 at 12:23:19AM +0000, Chris Boot wrote:
> > On 29 Nov 2005, at 0:28, Alexey Dobriyan wrote:
> > >echo kill >/proc/$PID/ctl
> > >	send SIGKILL to process
> > >
> > >echo term >/proc/$PID/ctl
> > >	send SIGTERM to process
> >
> > Pardon me for my ignorance, but what's wrong with the following?
> >
> > kill -KILL $PID
> >     and
> > kill -TERM $PID
> 
> kill(1) existence.

This is non sense, kill is included in the shell ! And if you need to
agressively reduce a binary size, a simple call to kill() will be
shorter than sprintf(), open(), write(), close().

> Not that I'm seriously proposing patch for inclusion.

so please don't pollute the list with useless patches that take time
to review.

Regards,
Willy


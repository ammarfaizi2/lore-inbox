Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbUK3Ajc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUK3Ajc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUK3AjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:39:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:44249 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261898AbUK3AgL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:36:11 -0500
Date: Mon, 29 Nov 2004 16:06:48 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roger Luethi <rl@hellgate.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 PATCH] visor: Make URB limit error more visible
Message-ID: <20041130000648.GA28436@kroah.com>
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com> <20041123193604.GA12605@k3.hellgate.ch> <20041124232527.GB4394@kroah.com> <20041125161619.GD18567@k3.hellgate.ch> <1101661884.16787.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101661884.16787.28.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 05:11:25PM +0000, Alan Cox wrote:
> On Iau, 2004-11-25 at 16:16, Roger Luethi wrote:
> > There is only one call to dev_dbg in all of visor.c, the rest is dbg or
> > dev_err. It already bit us once when warnings didn't turn up in a debug
> > log. I would argue that a flood of those warnings will warrant report
> > and inspection anyway (broken app, broken driver, or lame DoS attempt),
> > so I replaced the dev_dbg with dev_err.
> > 
> > Signed-off-by: Roger Luethi <rl@hellgate.ch>
> 
> Since it is trivially user caused should it not be rate limited or it
> becomes a DoS of its own to the syslog

Agreed, that's why the change I commited doesn't do it this way :)

thanks,

greg k-h

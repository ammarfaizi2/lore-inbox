Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUFQRwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUFQRwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUFQRwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:52:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:53469 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261321AbUFQRwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:52:11 -0400
Date: Thu, 17 Jun 2004 10:50:58 -0700
From: Greg KH <greg@kroah.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove EXPORT_SYMBOL(kallsyms_lookup)
Message-ID: <20040617175058.GA16640@kroah.com>
References: <20040617162927.GA12498@kroah.com> <200406171731.i5HHVA0M015051@car.linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406171731.i5HHVA0M015051@car.linuxhacker.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 08:31:10PM +0300, Oleg Drokin wrote:
> Hello!
> 
> Greg KH <greg@kroah.com> wrote:
> GK> Distros have started to ship kernels with this patch, as it seems that
> GK> some unnamed binary module authors are already abusing this function (as
> GK> well as some open source modules, like the openib code.)  I could not
> GK> find any valid reason why this symbol should be exported, so here's a
> 
> What if some extra carefully written code detects some (non fatal) problem in
> itself and decides to dump a decoded backtrace to some internal log buffer,
> user will find this later and will send a bugreport to developers?

Do you have an example of code in the current kernel tree that does
this?  If not, then feel free to bring up the discussion about exporting
this symbol at that point in time :)

> (yes, there are problems with simply doing dump_stack()).
> Or perhaps we need dump_stack version that will print the dump into a
> supplied buffer then?

That might be useful.

thanks,

greg k-h

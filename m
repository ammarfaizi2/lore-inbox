Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWDYMKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWDYMKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 08:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWDYMKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 08:10:40 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:44165 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751073AbWDYMKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 08:10:39 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: __FILE__ gets expanded to absolute pathname
Date: Tue, 25 Apr 2006 15:08:50 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200604251044.57373.vda@ilport.com.ua> <444E0D07.8060309@tls.msk.ru>
In-Reply-To: <444E0D07.8060309@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604251508.51028.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 14:50, Michael Tokarev wrote:
> Denis Vlasenko wrote:
> > Sometime ago I noticed that __FILE__ gets expanded into
> > *absolute* pathname if one builds kernel in separate object directory.
> > 
> > I thought a bit about it but failed to arrive at any sensible
> > solution.
> > 
> > Any thoughs?
> > --
> > vda
> > 
> > # strings vmlinux | grep /usr/src
> > /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/drivers/net/3c505.c
> > /.share/usr/src2/kernel/linux-2.6.16.via-rhine.src/arch/i386/kernel/time.c
> ....
> 
> As far as I remember, this happens when compiling with O=xxx only, ie,
> only when specifying alternative object (or source) directory.  Normally
> (when you compile in the source directory) they'll be like drivers/net/3c505.c,
> arch/i386/kernel/time.c etc, ie, relative to the kernel top source dir.
> It's because when you specify O= etc, complete source dir is passed from
> makefiles, instead of relative one.

Yes, of course you are right.
 
> But it was long time since I switched to symlink-tree + compile instead of
> compiling with O=, and things may had changed since that.

Doable, but it's not a solution, it's more like a workaround.
I'd prefer O=... build to not expand __FILE__ to full pathname.
--
vda

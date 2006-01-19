Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161269AbWASS6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbWASS6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 13:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWASS6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 13:58:09 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8467 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161269AbWASS6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 13:58:07 -0500
Date: Thu, 19 Jan 2006 19:57:20 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Fr?d?ric L. W. Meunier" <2@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: create .kernelrelease at *config step
Message-ID: <20060119185720.GA25157@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601191626140.1300@dyndns.pervalidus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601191626140.1300@dyndns.pervalidus.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 04:31:03PM -0200, Fr?d?ric L. W. Meunier wrote:
> Is this expected ?
> 
> $ cd /usr/local/src/kernel/linux-2.6.16
> $ make O=/home/fredlwm/objdir/ oldconfig
> ...
> make -C /usr/local/src/kernel/linux-2.6.16 O=/home/fredlwm/objdir 
> .kernelrelease
> Makefile:480: .config: No such file or directory
> 
> .config is in /home/fredlwm/objdir
> 
> .kernelrelease gets created in 
> /usr/local/src/kernel/linux-2.6.16 . I thought nothing would be 
> written to the sources directory. What if I were on a read-only 
> filesystem ?
> 
> I didn't try to build it. Are these harmless ?

This is a bug, I will post a simple patch shortly to fix it.

	Sam

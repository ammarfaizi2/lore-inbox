Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbTC0WIf>; Thu, 27 Mar 2003 17:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261436AbTC0WIf>; Thu, 27 Mar 2003 17:08:35 -0500
Received: from havoc.daloft.com ([64.213.145.173]:41873 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261412AbTC0WIU>;
	Thu, 27 Mar 2003 17:08:20 -0500
Date: Thu, 27 Mar 2003 17:19:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix .text.exit error in drivers/net/r8169.c
Message-ID: <20030327221929.GA3317@gtf.org>
References: <20030327221342.GC24744@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327221342.GC24744@fs.tum.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 11:13:42PM +0100, Adrian Bunk wrote:
> 
> In drivers/net/r8169.c the function rtl8169_remove_one is __devexit but 
> the pointer to it didn't use __devexit_p resulting in a.text.exit 
> compile error when !CONFIG_HOTPLUG.
> 
> The fix is simple:

Looks good, will apply.  Thanks.

	Jeff




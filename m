Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbTEIQAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTEIQAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:00:38 -0400
Received: from rth.ninka.net ([216.101.162.244]:22471 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263302AbTEIQAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:00:37 -0400
Subject: Re: ioctl32_unregister_conversion & modules
From: "David S. Miller" <davem@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20030509152436.GA762@elf.ucw.cz>
References: <20030509100039$6904@gated-at.bofh.it>
	 <200305091213.h49CDuO4029947@post.webmailer.de>
	 <20030509152436.GA762@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052496782.19951.3.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2003 09:13:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 08:24, Pavel Machek wrote:
> Fixing that would require resgister_ioctl32_conversion() to have 3-rd
> parameter "this module" and some magic inside fs/compat_ioctl.c,
> right?

That would do it.  I would suggest seperating out the static translation
handlers and the dynamically registered ones.  Now that you're adding
in module owner info, the translation tables are going to start bloating
up like crazy.

I'm still upset about going from 32-bit --> 64-bit entries on
sparc64 :-(

-- 
David S. Miller <davem@redhat.com>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274868AbTHPQhM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274871AbTHPQhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:37:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:9895 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S274868AbTHPQhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:37:09 -0400
Date: Sat, 16 Aug 2003 09:35:53 -0700
From: Greg KH <greg@kroah.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 current - firewire compile error
Message-ID: <20030816163553.GA9735@kroah.com>
References: <3F3E288B.3010105@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3E288B.3010105@cornell.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 08:50:19AM -0400, Ivan Gyurdiev wrote:
> Hopefully, this is not a duplicate post:
> ===========================================
> 
> drivers/ieee1394/nodemgr.c: In function `nodemgr_update_ud_names':
> drivers/ieee1394/nodemgr.c:471: error: structure has no member named `name'
> drivers/ieee1394/nodemgr.c: In function `nodemgr_create_node':
> drivers/ieee1394/nodemgr.c:723: error: structure has no member named `name'
> drivers/ieee1394/nodemgr.c: In function `nodemgr_update_node':
> drivers/ieee1394/nodemgr.c:1318: error: structure has no member named `name'
> drivers/ieee1394/nodemgr.c: In function `nodemgr_add_host':
> drivers/ieee1394/nodemgr.c:1775: error: structure has no member named `name'
> make[2]: *** [drivers/ieee1394/nodemgr.o] Error 1
> make[1]: *** [drivers/ieee1394] Error 2
> make: *** [drivers] Error 2

I removed struct device.name and forgot to change the firewire code :(

I'll work on a patch for this later this evening, unless someone beats
me to it.

Sorry,

greg k-h

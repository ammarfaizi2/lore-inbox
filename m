Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUENR6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUENR6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUENR6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:58:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:46786 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261976AbUENR6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:58:07 -0400
Date: Fri, 14 May 2004 10:57:32 -0700
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: BUG: ps2esdi causes kobject badness + OOPS
Message-ID: <20040514175732.GA1919@kroah.com>
References: <20040514104033.56e9ede4.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514104033.56e9ede4.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 10:40:33AM -0700, Randy.Dunlap wrote:
> 
> in 2.6.6 and 2.6.6-mm2.
> 
> 
> Calling initcall 0xc0fefc7e: ps2esdi_init+0x0/0x90()
> Badness in kobject_get at lib/kobject.c:429

That line means that this kobject was not initialized before we tried to
access it.  I don't know why this would be happening, but it's probably
due to the MCA initialization code somehow :)

Good luck,

greg k-h

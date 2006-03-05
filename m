Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752160AbWCEJUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbWCEJUm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 04:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbWCEJUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 04:20:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752160AbWCEJUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 04:20:41 -0500
Date: Sun, 5 Mar 2006 01:18:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: chris.leech@gmail.com, christopher.leech@intel.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Discourage duplicate symbols in the kernel? [Was: Intel I/O
 Acc...]
Message-Id: <20060305011852.368c016e.akpm@osdl.org>
In-Reply-To: <20060305090251.GA9116@mars.ravnborg.org>
References: <20060303214036.11908.10499.stgit@gitlost.site>
	<4408C2CA.5010909@garzik.org>
	<41b516cb0603031439n13e4df4cg8e5b21b606d2b4b8@mail.gmail.com>
	<20060305000933.2d799138.akpm@osdl.org>
	<20060305090251.GA9116@mars.ravnborg.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Sun, Mar 05, 2006 at 12:09:33AM -0800, Andrew Morton wrote:
>  > > +
>  > > +static inline u8 read_reg8(struct cb_device *device, unsigned int offset)
>  > > +{
>  > > +	return readb(device->reg_base + offset);
>  > > +}
>  > 
>  > These are fairly generic-sounding names.  In fact the as-yet-unmerged tiacx
>  > wireless driver is already using these, privately to
>  > drivers/net/wireless/tiacx/pci.c.
> 
>  Do we in general discourage duplicate symbols even if they are static?

Well, it's a bit irritating that it confuses ctags.  But in this case, one
set is in a header file so the risk of collisions is much-increased.


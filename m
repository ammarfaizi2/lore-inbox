Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVAaWdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVAaWdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVAaWdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:33:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:207 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261406AbVAaWdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:33:40 -0500
Date: Mon, 31 Jan 2005 14:33:32 -0800
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux, part 2
Message-ID: <20050131223332.GA25419@kroah.com>
References: <16890.38062.477373.644205@tut.ibm.com> <20050129081527.GD7738@kroah.com> <41FEACD3.10502@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FEACD3.10502@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 05:10:27PM -0500, Karim Yaghmour wrote:
> 
> Greg KH wrote:
> > On Fri, Jan 28, 2005 at 01:38:22PM -0600, Tom Zanussi wrote:
> > 
> >>+extern void * alloc_rchan_buf(unsigned long size,
> >>+			      struct page ***page_array,
> >>+			      int *page_count);
> >>+extern void free_rchan_buf(void *buf,
> >>+			   struct page **page_array,
> >>+			   int page_count);
> > 
> > 
> > As these will be "polluting" the global namespace of the kernel, could
> > you add "relayfs_" to the front of them?
> 
> BTW, these functions are in buffers.h which is an internal header to
> fs/relayfs/*.c files. buffers.h is not included in anything outside.
> Correct me if I'm wrong, but there is no namespace pollution in that
> case, right? All that does contribute to namespace pollution is in
> include/linux/relayfs_fs.h.

When relayfs is built into the kernel, those symbols are then global to
the whole static kernel.

Please be nice and rename them.

thanks,

greg k-h

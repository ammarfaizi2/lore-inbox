Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbUDAS5S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 13:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbUDAS5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 13:57:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:34993 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263060AbUDAS5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 13:57:12 -0500
Date: Thu, 1 Apr 2004 10:55:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Olof Johansson <olof@austin.ibm.com>
Cc: manfred@colorfullife.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       anton@samba.org
Subject: Re: Oops in get_boot_pages at reboot
Message-Id: <20040401105553.38468a64.akpm@osdl.org>
In-Reply-To: <Pine.A41.4.44.0403312015050.29064-100000@forte.austin.ibm.com>
References: <Pine.A41.4.44.0403312015050.29064-100000@forte.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson <olof@austin.ibm.com> wrote:
>
> So __pollwait() calls __get_free_page(), system_running is 0 so
>  get_boot_pages is called. Since get_boot_pages is labeled __init, badness
>  happens.
> 
>  How about checking against mem_init_done instead of system_running? It
>  helps against the oops, but there might be some good reason not to do
>  it. I don't claim to know the intrisic details about the MM. :-)

Do we really need to clear system_running at reboot?  I'd always viewed it
as "everything is initialised and usable", and that's generally true at
reboot time.


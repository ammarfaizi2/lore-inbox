Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbUD2Bhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUD2Bhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUD2BfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:35:11 -0400
Received: from ozlabs.org ([203.10.76.45]:38847 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262538AbUD2Bdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:33:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16528.23219.17557.608276@cargo.ozlabs.ibm.com>
Date: Thu, 29 Apr 2004 11:30:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <20040428180038.73a38683.akpm@osdl.org>
References: <409021D3.4060305@fastclick.com>
	<20040428170106.122fd94e.akpm@osdl.org>
	<409047E6.5000505@pobox.com>
	<40905127.3000001@fastclick.com>
	<20040428180038.73a38683.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> My point is that decreasing the tendency of the kernel to swap stuff out is
> wrong.  You really don't want hundreds of megabytes of BloatyApp's
> untouched memory floating about in the machine.  Get it out on the disk,
> use the memory for something useful.

What I have noticed with 2.6.6-rc1 on my dual G5 is that if I rsync a
gigabyte or so of data over to another machine, it then takes several
seconds to change focus from one window to another.  I can see it
slowly redraw the window title bars.  It looks like the window manager
is getting swapped/paged out.

This machine has 2.5GB of ram, so I really don't see why it would need
to swap at all.  There should be plenty of page cache pages that are
clean and not in use by any process that could be discarded.  It seems
like as soon as there is any memory shortage at all it picks on the
window manager and chucks out all its pages. :(

Paul.

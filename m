Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265959AbUGZTCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUGZTCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUGZTCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:02:21 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:28087 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266130AbUGZREO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 13:04:14 -0400
Subject: Re: [announce] HVCS for inclusion in 2.6 tree
From: Ryan Arnold <rsa@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20040722185733.2806e615.akpm@osdl.org>
References: <1089819720.3385.66.camel@localhost>
	 <16633.55727.513217.364467@cargo.ozlabs.ibm.com>
	 <1090528007.3161.7.camel@localhost> <20040722185733.2806e615.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1090847830.3161.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 09:41:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-22 at 20:57, Andrew Morton wrote:
> A little stylistic thing:
> 
> > +	struct hvcs_struct *hvcsd = (struct hvcs_struct *)tty->driver_data;
> > +	struct hvcs_struct *hvcsd = (struct hvcs_struct *)tty->driver_data;
> > +	struct hvcs_struct *hvcsd = (struct hvcs_struct *)dev_instance;
> 
> It's not necessary to add a typecast when assigning to and from a void*. 
> In fact, it's harmful: if someone were to later change, say,
> tty->driver_data to a `struct foo *', your typecast will suppress the
> warning which we would very much like to receive.

Easy enough to fix.  Thanks, I'll take care of it.

Ryan S. Arnold
IBM Linux Technology Center


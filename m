Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUIPMHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUIPMHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUIPMHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:07:52 -0400
Received: from pop.gmx.de ([213.165.64.20]:63938 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268028AbUIPMHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:07:37 -0400
X-Authenticated: #1725425
Date: Thu, 16 Sep 2004 14:21:09 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Peter Jones <pjones@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-NEW] allow root to modify raw scsi command permissions
 list
Message-Id: <20040916142109.6fc7223c.Ballarin.Marc@gmx.de>
In-Reply-To: <1095291378.5945.4.camel@localhost.localdomain>
References: <1095173470.5728.3.camel@localhost.localdomain>
	<20040915230813.6eac1d04.Ballarin.Marc@gmx.de>
	<1095284325.20749.8.camel@localhost.localdomain>
	<20040916013351.1422170f.Ballarin.Marc@gmx.de>
	<1095291378.5945.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 19:36:18 -0400
Peter Jones <pjones@redhat.com> wrote:

> Yes.
> 
> Here's another version of the patch.  It does what yours did, as well as
> that.  It also combines the read and write code so there's one of each,
> with a parameter to tell which it's supposed to modify.

Looks *slightly* better than mine ;-)

But

> +static ssize_t rcf_cmds_store(struct rawio_cmd_filter *rcf, const char *page,
> +			size_t count, int rw)
	...
> +		ss.from = (char *)page+ret;
> +		ss.to = (char *)page+ret+1;

needs to be

> +		ss.from = (char *)page+ret;
> +		ss.to = (char *)page+ret+2;

Regards

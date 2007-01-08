Return-Path: <linux-kernel-owner+w=401wt.eu-S1161197AbXAHIhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbXAHIhY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161199AbXAHIhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:37:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34033 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161197AbXAHIhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:37:23 -0500
Date: Mon, 8 Jan 2007 08:37:21 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Hua Zhong <hzhong@gmail.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Message-ID: <20070108083721.GE17561@ftp.linux.org.uk>
References: <84144f020701080000v460a9f3aja9570e72fa457934@mail.gmail.com> <810563.91187.qm@web55604.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810563.91187.qm@web55604.mail.re4.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 12:31:44AM -0800, Amit Choudhary wrote:
> 
> --- Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> 
> > On 1/8/07, Hua Zhong <hzhong@gmail.com> wrote:
> > > > And as I explained, it can result in longer code too. So, why
> > > > keep this value around. Why not re-initialize it to NULL.
> > >
> > > Because initialization increases code size.
> > 
> > And it also effectively blocks the slab debugging code from doing its
> > job detecting double-frees.
> > 
> 
> Man, so you do want someone to set 'x' to NULL after freeing it, so that the slab debugging code
> can catch double frees. If you set it to NULL then double free is harmless. So, you want something
> harmful in the system and then debug it with the slab debugging code. Man, doesn't make sense to
> me.

_Definitely_ cargo-cult programming...

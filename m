Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWIYRjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWIYRjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWIYRja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:39:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41163 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751338AbWIYRj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:39:28 -0400
Date: Mon, 25 Sep 2006 18:39:23 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Luben Tuikov <ltuikov@yahoo.com>
Cc: dougg@torque.net, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix idiocy in asd_init_lseq_mdp()
Message-ID: <20060925173922.GL29920@ftp.linux.org.uk>
References: <4517EBF7.4020508@torque.net> <20060925171634.69667.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925171634.69667.qmail@web31809.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 10:16:34AM -0700, Luben Tuikov wrote:
> --- Douglas Gilbert <dougg@torque.net> wrote:
> > Al Viro wrote:
> > > To whoever had written that code:
> > > 
> > > a) priority of >> is higher than that of &
> > > b) priority of typecast is higher than that of any binary operator
> > > c) learn the fscking C
> [...]
> > BTW Luben was pointing out that the call you patched
> > and the following call can be combined into a less
> > trouble prone asd_write_reg_dword() call.
> 
> More than that -- I looked at the history of that
> file/line and the code as I had written it _never_ had
> that broken cast and shift mess.

Far more interesting question: where does the hardware expect to see the
upper 16 bits of that 32bit value?  Which one it is - LmSEQ_INTEN_SAVE(lseq)
ori LmSEQ_INTEN_SAVE(lseq) + 2?

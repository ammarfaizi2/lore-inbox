Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVAYMt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVAYMt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVAYMt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:49:28 -0500
Received: from speedy.student.utwente.nl ([130.89.163.131]:61824 "EHLO
	speedy.student.utwente.nl") by vger.kernel.org with ESMTP
	id S261923AbVAYMtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:49:14 -0500
Date: Tue, 25 Jan 2005 13:49:09 +0100
From: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Subject: Re: Linux 2.6.11-rc2: vmnet breaks; put skb_copy_datagram b
Message-ID: <20050125124909.GA10874@speedy.student.utwente.nl>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@osdl.org
References: <75C33211637@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75C33211637@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:46:56AM +0100, Petr Vandrovec wrote:
> On 25 Jan 05 at 1:41, Sytse Wielinga wrote:
> > Linus, could you please put skb_copy_datagram back in place? It's not used
> > anymore in the kernel, but the vmnet module (in vmware) still uses this
> > interface to skb_copy_datagram_iovec.
> 
> There is no reason for doing this.  Just grab latest vmmon & vmnet
> from http://platan.vc.cvut.cz/ftp/pub/vmware/vmware-any-any-update89.tar.gz,
> and enjoy latest and greatest modules.  Besides this one you'll get lot
> of other fixes and improvements for free ;-)

I'm very sorry, you're completely right. That version uses
skb_copy_datagram_iovec. I'll file a bug for gentoo instead, that it needs to
update from 88 to 89.

On the other hand, though, I would think it would be a good idea to leave this
function in until after 2.6.11, so that distributions and people have plenty of
time to update their vmware. After all, it's not like we'd be missing out on an
important fix or something; we're just moving a couple of bytes out of the
kernel into vmnet.

    Sytse

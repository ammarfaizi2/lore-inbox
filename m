Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263611AbUEMAGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbUEMAGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 20:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbUEMAGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 20:06:04 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:51929 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S263611AbUEMAGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 20:06:01 -0400
Date: Wed, 12 May 2004 17:07:17 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Christoph Hellwig <hch@infradead.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: GCC nested functions?
Message-ID: <20040513000712.GA29796@gaz.sfgoth.com>
References: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net> <20040512190454.A31410@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512190454.A31410@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> nested function are a horrible gcc misfeature.

True.

> So far people had enough
> taste to not introduce them without explicitly forbidding it ;-)

Almost true.  Look at drivers/atm/horizon.c:make_rate(), which includes
a nested function called "set_cr()"  There may be a couple other
examples in the drivers/atm directory, not sure.

The Intel CC guys made special mention of the ATM drivers when they
first started using their compiler for the kernel (icc supports most
gcc extensions, but apparently not nested functions) and they made special
mention of not being able to compile some ATM drivers because of this.

I'm not aware of nested functions anywhere else in the kernel though.

-Mitch

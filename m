Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVANT1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVANT1V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVANTOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:14:04 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:15600 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262021AbVANTLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:11:34 -0500
Date: Fri, 14 Jan 2005 11:10:13 -0800
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 4/4] relayfs for 2.6.10: headers
Message-ID: <20050114191013.GB15337@kroah.com>
References: <41E736C4.3080806@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E736C4.3080806@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:04:36PM -0500, Karim Yaghmour wrote:
> +/**
> + *	have_cmpxchg - does this architecture have a cmpxchg?
> + *
> + *	Returns 1 if this architecture has a cmpxchg useable by
> + *	the lockless scheme, 0 otherwise.
> + */
> +static inline int
> +have_cmpxchg(void)
> +{
> +#if defined(__HAVE_ARCH_CMPXCHG)
> +	return 1;
> +#else
> +	return 0;
> +#endif
> +}

Shouldn't this be a build time check, and not a runtime one?


Return-Path: <linux-kernel-owner+w=401wt.eu-S1751160AbXANHxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbXANHxs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 02:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbXANHxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 02:53:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:40045 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbXANHxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 02:53:47 -0500
Date: Sat, 13 Jan 2007 23:43:08 -0800
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block device driver.
Message-ID: <20070114074308.GC10585@kroah.com>
References: <20070113014539.408244126@goop.org> <20070113014649.256179743@goop.org> <1168736848.3123.352.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168736848.3123.352.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2007 at 05:07:28PM -0800, Arjan van de Ven wrote:
> > +
> > +#define DPRINTK(_f, _a...) pr_debug(_f, ## _a)
> 
> why this silly abstraction? Just use pr_debug in the code directly

Actually, for drivers, like this one, you should use the dev_printk()
and friends (dev_dbg, dev_err, etc.) instead so that userspace knows
exactly which device and driver the message comes from.

thanks,

greg k-h

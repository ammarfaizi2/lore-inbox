Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVAUHtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVAUHtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVAUHtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:49:18 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:27561 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262300AbVAUHtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:49:13 -0500
Subject: Re: 2.6.11-rc1 vs. PowerMac 8500/G3 (and VAIO laptop) [usb-storage
	oops]
From: David Woodhouse <dwmw2@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: John Mock <kd6pag@qsl.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050121000822.GA14580@kroah.com>
References: <E1CrPQ4-0000pW-00@penngrove.fdns.net>
	 <1106210408.6932.27.camel@localhost.localdomain>
	 <20050121000822.GA14580@kroah.com>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 07:49:08 +0000
Message-Id: <1106293748.783.31.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-20 at 16:08 -0800, Greg KH wrote:
> Doh, sorry for missing this one.  I've applied your patch to my trees,
> and will show up in the next -mm release.

Actually I think John's problem was that the usb core code has now
_stopped_ doing this byteswapping, and he has a lsusb which is hacked to
expect it. So if you apply my patch you're preserving the userspace ABI
by reverting to the extremely stupid behaviour of byteswapping _some_ of
the fields in the descriptor we pass to userspace.

-- 
dwmw2



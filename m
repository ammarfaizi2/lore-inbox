Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262637AbTCTV4x>; Thu, 20 Mar 2003 16:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262643AbTCTV4x>; Thu, 20 Mar 2003 16:56:53 -0500
Received: from air-2.osdl.org ([65.172.181.6]:49792 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262637AbTCTV4w>;
	Thu, 20 Mar 2003 16:56:52 -0500
Date: Thu, 20 Mar 2003 14:06:51 -0800
From: Bob Miller <rem@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@m17n.org, gniibe@m17n.org,
       kkojima@rr.iij4u.or.jp
Subject: Re: [PATCH] reduce stack usage in arch/sh/kernel/pci-sh7751
Message-ID: <20030320220651.GB16501@doc.pdx.osdl.net>
References: <20030320120833.2ddbfcc1.rddunlap@osdl.org> <20030320215910.GA16501@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320215910.GA16501@doc.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 01:59:11PM -0800, Bob Miller wrote:
> On Thu, Mar 20, 2003 at 12:08:33PM -0800, Randy.Dunlap wrote:
> > +
> > +	bus = kmalloc(sizeof(*bus), GFP_ATOMIC);
> > +	dev = kmalloc(sizeof(*dev), GFP_ATOMIC);
> > +	if (!bus || !dev) {
> > +		printk(KERN_ERR "Out of memory in %s\n", __FUNCTION__);
> > +		goto exit;
> > +	}
> > +
> If the kmalloc() for bus succeeds but for dev fails this will leak the
> memory given to bus.
> 
That's a goto, not a return... Never mind.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbTBQRFH>; Mon, 17 Feb 2003 12:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbTBQRFH>; Mon, 17 Feb 2003 12:05:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:35200 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267159AbTBQRFG>;
	Mon, 17 Feb 2003 12:05:06 -0500
Date: Mon, 17 Feb 2003 09:15:02 -0800
From: Bob Miller <rem@osdl.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.60 2/9] Update parport class driver to new module loader API.
Message-ID: <20030217171502.GB23052@doc.pdx.osdl.net>
References: <20030214234557.GC13336@doc.pdx.osdl.net> <20030215111642.A17769@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030215111642.A17769@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 11:16:42AM +0000, Christoph Hellwig wrote:
> On Fri, Feb 14, 2003 at 03:45:57PM -0800, Bob Miller wrote:
> > -	void (*inc_use_count)(void);
> > +	int (*inc_use_count)(void);
> >  	void (*dec_use_count)(void);
> 
> This is broken.  You need
> 
> 	struct module *owner;
> 
> here and use try_module_et/module_put before calling into the module.

Christoph,

Thanks for taking the time to review this.  Your comments are similar
to Russell King's.  I'll fix this and then re-submit.  Thanks again.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbTCYDmd>; Mon, 24 Mar 2003 22:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbTCYDmd>; Mon, 24 Mar 2003 22:42:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45840 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261405AbTCYDmc>;
	Mon, 24 Mar 2003 22:42:32 -0500
Date: Mon, 24 Mar 2003 19:53:08 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Christoph Hellwig <hch@infradead.org>, Dominik Kubla <dominik@kubla.de>,
       linux-kernel@vger.kernel.org
Subject: Re: i2c-via686a driver
Message-ID: <20030325035308.GF11874@kroah.com>
References: <3E7E0B37.5060505@portrix.net> <20030323202743.A11150@infradead.org> <200303232136.10089.dominik@kubla.de> <20030323204810.A11421@infradead.org> <3E7E2963.4070302@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7E2963.4070302@portrix.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 10:38:43PM +0100, Jan Dittmer wrote:
> Christoph Hellwig wrote:
> >On Sun, Mar 23, 2003 at 09:36:10PM +0100, Dominik Kubla wrote:
> >
> >>Why? It's a valid C99 feature and since the kernel already uses C99 
> >>initializers it won't compile with compilers that choke on C99 comments 
> >>anyway.
> >
> >
> >Because there's a strong preference for traditional C style in the kernel.
> >typedefs are also a valid C feature and we try to avoid them.
> >
> Anyway, here is a corrected version.
> Jan

Looks good, thanks.

But could you also convert all of the printk() calls to use the dev_*()
calls instead?  That will also fix the problem that none of those calls
in this driver are using the KERN_* levels for printk(), which is
required.

Other than that minor thing, looks a lot better, thanks.

greg k-h

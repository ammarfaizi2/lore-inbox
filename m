Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVDEJkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVDEJkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVDEJfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:35:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47070 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261208AbVDEJdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:33:06 -0400
Subject: Re: 2.6.12-rc2-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Dave Airlie <airlied@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <16978.22617.338768.775203@cargo.ozlabs.ibm.com>
References: <20050405000524.592fc125.akpm@osdl.org>
	 <20050405074405.GE26208@infradead.org>
	 <21d7e99705040502073dfa5e5@mail.gmail.com>
	 <16978.22617.338768.775203@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 11:33:00 +0200
Message-Id: <1112693580.6275.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 19:20 +1000, Paul Mackerras wrote:
> Dave Airlie writes:
> 
> > Paulus these look like your patches care to update them with the "new"
> > method of doing stuff..
> 
> What are we going to do about the DRM CVS?  Change it to the new way
> and break everyone running 2.6.10 or earlier, or leave it at the old
> way that will work for people with distro kernels, and have a
> divergence between it and what's in the kernel?

(some distros like Fedora Core have modern kernels even for older
releases)


> Also, the compat_ioctl method is called without the BKL held, unlike
> the ioctl method.  What impact will that have?  Do we need to take the
> BKL in the compat_ioctl method?

How much does DRM actually depend on the BKL? I would hope not too
much...


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWHCOMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWHCOMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWHCOMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:12:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24032 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932485AbWHCOME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:12:04 -0400
Date: Thu, 3 Aug 2006 15:11:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Arjan van de Ven <arjan@infradead.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net, linville@tuxdriver.com, jt@hpl.hp.com
Subject: Re: orinoco driver causes *lots* of lockdep spew
Message-ID: <20060803141153.GB20405@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Arjan van de Ven <arjan@infradead.org>, davej@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, linville@tuxdriver.com, jt@hpl.hp.com
References: <1154607380.2965.25.camel@laptopd505.fenrus.org> <E1G8der-0001fm-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1G8der-0001fm-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 11:54:41PM +1000, Herbert Xu wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> > 
> > this is another one of those nasty buggers;
> 
> Good catch.  It's really time that we fix this properly rather than
> adding more kludges to the core code.
> 
> Dave, once this goes in you can revert the previous netlink workaround
> that added the _bh suffix.
> 
> [WIRELESS]: Send wireless netlink events with a clean slate

Could we please just get rid of the wireless extensions over netlink code
again?  It doesn't help to solve anything and just creates a bigger mess
to untangle when switching to a fully fledged wireless stack.


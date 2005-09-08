Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVIHQ2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVIHQ2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVIHQ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:28:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42635 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964893AbVIHQ2L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:28:11 -0400
Date: Thu, 8 Sep 2005 17:28:09 +0100
From: viro@ZenIV.linux.org.uk
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Beulich <JBeulich@novell.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add stricmp
Message-ID: <20050908162809.GB9623@ZenIV.linux.org.uk>
References: <43206F420200007800024455@emea1-mh.id2.novell.com> <20050908151754.GB11067@infradead.org> <432074B302000078000244A3@emea1-mh.id2.novell.com> <1126195489.19834.39.camel@localhost.localdomain> <432078D102000078000244D5@emea1-mh.id2.novell.com> <1126197433.19834.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126197433.19834.47.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:37:13PM +0100, Alan Cox wrote:
> On Iau, 2005-09-08 at 17:45 +0200, Jan Beulich wrote:
> > >The only general, usable strnicmp safe for general kernel use would be
> > a
> > >full all singing all dancing UTF-8 symbol aware arbitary locale
> > >implementation. And that we *definitely* do not want in kernel.
> > 
> > Then you'd want to immediately get rid of the mentioned, pre-exisiting
> > strnicmp().
> 
> Yes

There is a couple of legitimate uses of that one - mostly in workarounds for
bugs in unrelated programs...  Most of the strnicmp() users should go, though.

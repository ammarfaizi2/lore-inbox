Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264352AbUFPRxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264352AbUFPRxa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbUFPRxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:53:30 -0400
Received: from [213.146.154.40] ([213.146.154.40]:21917 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264312AbUFPRx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:53:27 -0400
Date: Wed, 16 Jun 2004 18:53:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Mark Salyzyn <mark_salyzyn@adaptec.com>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aacraid 32/64 ioctl support (update)
Message-ID: <20040616175325.GA16751@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Haverkamp <markh@osdl.org>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Mark Salyzyn <mark_salyzyn@adaptec.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1087401137.13488.61.camel@markh1.pdx.osdl.net> <20040616160107.GA14144@infradead.org> <20040616160232.GB14144@infradead.org> <1087405920.13488.82.camel@markh1.pdx.osdl.net> <20040616171924.GA15925@infradead.org> <1087408316.13488.93.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087408316.13488.93.camel@markh1.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Although the compat_alloc_user_space implementations I looked at don't fail I
> > think a check for NULL wouldn't hurt.
> 
> The places that I looked where they check the return value use
> access_ok().  What do you think?

 
> > > +	f = compat_alloc_user_space(sizeof(*f));
> 
> I just noticed this.  Can we use memset on a user pointer?  If not, what
> would be the best way to handle this?


Good question.  Maybe the architecture-folks know an answer?
 

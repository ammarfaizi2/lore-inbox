Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUI0JAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUI0JAZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUI0JAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:00:24 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:62226 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266357AbUI0JAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:00:21 -0400
Date: Mon, 27 Sep 2004 10:00:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i386 entry.S problems
Message-ID: <20040927100018.A22468@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
References: <s157d11c.077@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <s157d11c.077@emea1-mh.id2.novell.com>; from JBeulich@novell.com on Mon, Sep 27, 2004 at 09:37:10AM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 09:37:10AM +0200, Jan Beulich wrote:
> >>> Christoph Hellwig <hch@infradead.org> 24.09.04 21:12:51 >>>
> >> +#if !defined(CONFIG_REGPARM) || __GNUC__ < 3
> >>  	pushl %ebp
> >> +#endif
> >
> >CONFIG_REGPARM n eeds gcc 3.0 or later
> 
> Not sure what you try to point out here: the additions account for
> exactly that.

No, the || __GNUC__ < 3 is superflous.  if CONFIG_REGPARM is defined
and __GNUC__ < 3 you have problems elsewhere already.


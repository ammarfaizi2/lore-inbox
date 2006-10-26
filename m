Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423533AbWJZOlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423533AbWJZOlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 10:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423537AbWJZOlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 10:41:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:15520 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1423534AbWJZOlV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 10:41:21 -0400
Date: Thu, 26 Oct 2006 15:41:17 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, proski@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
Message-ID: <20061026144117.GI29920@ftp.linux.org.uk>
References: <1161807069.3441.33.camel@dv> <1161808227.7615.0.camel@localhost.localdomain> <20061025205923.828c620d.akpm@osdl.org> <1161859199.12781.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161859199.12781.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 11:39:59AM +0100, Alan Cox wrote:
> Ar Mer, 2006-10-25 am 20:59 -0700, ysgrifennodd Andrew Morton:
> > May be so.  But this patch was supposed to print a helpful taint message to
> > draw our attention to the fact that ndis-wrapper was in use.  The patch was
> > not intended to cause gpl'ed modules to stop loading 
> 
> The stopping loading is purely because it now uses _GPLONLY symbols,
> which is fine until the user wants to load a windows driver except for
> the old CIPE driver. Some assumptions broke somewhere along the way and
> the chain of events that was never forseen unfolded.

Could we please decide WTF _GPLONLY *is* and at least remain consistent?
Aside of "method of fighting binary-only modules", that is - this part
is obvious.

I'm not fond of ndiswrapper and stuff it uses, but AFAICS the list of
symbols it uses doesn't look like poking in the guts of kernel.

ISTR explanations along the lines of "well, it's for the stuff that
shouldn't be used by out-of-tree code".  Does anybody still subscribe
to that or should that be considered a pure smokescreen?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWHXN6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWHXN6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWHXN6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:58:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:2718 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751552AbWHXN6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:58:16 -0400
Date: Thu, 24 Aug 2006 08:58:03 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: "Serge E. Hallyn" <sergeh@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       kjhall@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       David Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>
Subject: Re: [PATCH 3/7] SLIM main patch
Message-ID: <20060824135803.GA32764@sergelap.austin.ibm.com>
References: <1156359937.6720.66.camel@localhost.localdomain> <20060823192733.GG28594@kvack.org> <1156365357.6720.87.camel@localhost.localdomain> <1156418815.3007.89.camel@localhost.localdomain> <20060824133248.GC15680@sergelap.austin.ibm.com> <20060824133733.GK28594@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824133733.GK28594@kvack.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Benjamin LaHaise (bcrl@kvack.org):
> On Thu, Aug 24, 2006 at 08:32:48AM -0500, Serge E. Hallyn wrote:
> > > You also have to deal with existing mmap() mappings and outstanding I/O.
> > 
> > That she does.
> 
> Outstanding I/O is not revoked.  Any in-progress I/O continues.

Yes, that should have read:

> > > You also have to deal with existing mmap() mappings
> > 
> > That she does.
> >
> > > and outstanding I/O.

Still not certain this is needed.  If you were able to write data to a
pipe, then even though data may be in the buffer, the other end
shouldn't be able to read it if it's own level were changed.

-serge

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266368AbUAHW7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266371AbUAHW7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:59:44 -0500
Received: from mail.ccur.com ([208.248.32.212]:25607 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S266368AbUAHW7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:59:35 -0500
Date: Thu, 8 Jan 2004 17:59:29 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040108225929.GA24089@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040107165607.GA11483@rudolph.ccur.com> <20040107113207.3aab64f5.akpm@osdl.org> <20040108051111.4ae36b58.pj@sgi.com> <16381.57040.576175.977969@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16381.57040.576175.977969@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  ==> However, _within_ each word, I suspect that I have the bytes arse
> > backwards on a big endian machine.  The underlying snprintf("%x") and
> > strtoul() routines that I call will presume that the byte order of the
> > referenced u32 binary word is native (big on big endian).  Not good.
> 
> Why do you have to reference them as u32?  Why can't you use unsigned
> long instead?  That should Just Work.

I believe he wants the commas to group the digits by at most eight
irrespective of architecture.  Which seems reasonable.

Joe

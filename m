Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTKFAw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 19:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTKFAw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 19:52:29 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:47268 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263221AbTKFAw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 19:52:28 -0500
Date: Thu, 6 Nov 2003 01:52:24 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Larry McVoy <lm@work.bitmover.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BK2CVS problem
Message-ID: <20031106005224.GA7105@louise.pinerecords.com>
References: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com> <20031105230350.GB12992@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031105230350.GB12992@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov-05 2003, Wed, 15:03 -0800
Larry McVoy <lm@bitmover.com> wrote:

> > > > +       if ((options == (__WCLONE|__WALL)) && (current->uid = 0))
> > > > +                       retval = -EINVAL;
> > > 
> > > That looks odd
> > 
> > Setting current->uid to zero when options __WCLONE and __WALL are set?  The 
> > retval is dead code because of the next line, but it looks like an attempt
> > to backdoor the kernel, does it not?
> 
> It sure does.  Note "current->uid = 0", not "current->uid == 0". 
> Good eyes, I missed that.  This function is sys_wait4() so by passing in
> __WCLONE|__WALL you are root.  How nice.

Also note the extra parentheses to avoid a gcc warning.

-- 
Tomas Szepe <szepe@pinerecords.com>

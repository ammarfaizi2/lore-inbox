Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVCUDUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVCUDUM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 22:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVCUDUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 22:20:12 -0500
Received: from are.twiddle.net ([64.81.246.98]:41091 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261524AbVCUDUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 22:20:07 -0500
Date: Sun, 20 Mar 2005 19:19:52 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Dan Kegel <dank@kegel.com>, jbglaw@lug-owl.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.3 build problem in arch/alpha/kernel/srcons.c with gcc-4.0
Message-ID: <20050321031952.GA1381@twiddle.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Dan Kegel <dank@kegel.com>,
	jbglaw@lug-owl.de, linux-kernel@vger.kernel.org
References: <423E238F.3030805@kegel.com> <20050320190352.65cc1396.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050320190352.65cc1396.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2005 at 07:03:52PM -0800, Andrew Morton wrote:
> Dan Kegel <dank@kegel.com> wrote:
> >
> > Anyone with an alpha care to suggest a fix for this?
> > 
> > arch/alpha/kernel/srmcons.c: In function 'srmcons_open':
> > arch/alpha/kernel/srmcons.c:196: warning: 'srmconsp' may be used uninitialized in this function
> > make[1]: *** [arch/alpha/kernel/srmcons.o] Error 1
> > make: *** [arch/alpha/kernel] Error 2
> > 
> > I get this when building the 2.6.11.3 kernel with a recent gcc-4.0 snapshot.
> > 
> 
> It's beyond gcc's ability to figure out that the code is OK.  Options would
> be to disable -Werror, or to artificially initialise that variable.

I've a fix in my local tree.  I'll pass it along shortly.



r~

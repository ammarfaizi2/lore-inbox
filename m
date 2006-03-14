Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWCNJsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWCNJsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 04:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWCNJsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 04:48:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49337 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751260AbWCNJsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 04:48:43 -0500
Date: Tue, 14 Mar 2006 10:47:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, ext2-devel <Ext2-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add "-o bh" option to ext3
Message-ID: <20060314094745.GA10870@elf.ucw.cz>
References: <1142016591.21442.38.camel@dyn9047017100.beaverton.ibm.com> <20060313095215.GA3700@elf.ucw.cz> <1142296405.21442.54.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142296405.21442.54.camel@dyn9047017100.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Its not really need for now, but as we try to make "nobh"
> > > as default option, it would be nice to have a "-obh" fallback
> > > option - if things go wrong.
> > 
> > Docs patch is missing...
> > 
> > ...and no, it is not even clear to me what bh vs. nobh does...
> 
> Hope this helps.

Not really, I still am not sure what it does. Is it like "nobh is more
effective code, and should have exactly zero impact to the user, but
as it is new, we make it optional"?

								Pavel

> @@ -113,6 +113,14 @@ noquota
>  grpquota
>  usrquota
>  
> +bh		(*)	ext3 associates buffer heads to data pages to
> +nobh			(a) cache disk block mapping information

missing full stop?

> +			(b) link pages into transaction to provide
> +			    ordering guarantees.
> +			"bh" option forces use of buffer heads.
> +			"nobh" option tries to avoid associating buffer
> +			heads (supported only for "writeback" mode).
> +

-- 
15:        try

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263755AbUC3REL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbUC3REL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:04:11 -0500
Received: from mail.cyclades.com ([64.186.161.6]:38381 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263755AbUC3REF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:04:05 -0500
Date: Tue, 30 Mar 2004 13:51:52 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jaco Kroon <jkroon@cs.up.ac.za>
Cc: Fredrik Steen <fredrik@stone.nu>, linux-kernel@vger.kernel.org,
       dwmw2@infradead.org
Subject: Re: 2.4: kernel BUG at inode.c:334!
Message-ID: <20040330165152.GA5989@logos.cnet>
References: <90520000.1080235942@flay> <20040326154915.GC3472@logos.cnet> <20040326155806.GD3472@logos.cnet> <20040326154000.GA28389@panic.unixguru.info> <20040326183959.GC4218@logos.cnet> <4069898D.90005@cs.up.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4069898D.90005@cs.up.ac.za>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 04:51:57PM +0200, Jaco Kroon wrote:

> So this seems to be a more general problem (My co-worker suspects ext3 - 
> since this bug report started with xfs that might not be the case).  The 
> only pattern we are seeing between all of these is that they serve as 
> nfs servers (but on mine at home it still dies, even when not serving 
> nfs - it still is a nfs client when it dies though), are not the newest 
> and greatest machines and all of them use ext3 as their root file 
> system.  Oh, also, usually shortly after, or during, intensive disk io - 
> which match up with what Mika mentioned.  I've also tried disabling 
> IO-APIC (which we're not even sure is supported, but APIC is), as well 
> as pre-empting.
> 
> We don't suspect nfs on the production machines anymore since we managed 
> to trash the nfs exported dir for about an hour (keeping the server at 
> load average 8.5) which makes use of reiserfs - we might've been lucky 
> though.  In almost all the cases these exports are relatively big 
> though, and I noticed there is a problem there as well (We don't get the 
> magical 1000 number quite yet).
> 
> Is there anything else I should/can take a look at?  Is there any other 
> way in which I can help find the problem?  If I can just get somewhere 
> to start ... (The patch below doesn't apply to 2.6 as far as I can see).
> 
> Apologies for the essay.

Jaco, 

The "kernel BUG at inode.c:340" problem is fixed in 2.4.26-rc1. 
If that was what you were hitting, can you try that on  your servers

About the other crashes, its hard to help without more information. Try attaching
a serial cable to the box for serial console.

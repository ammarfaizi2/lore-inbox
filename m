Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTFPDpI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 23:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTFPDpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 23:45:08 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:43785 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263309AbTFPDpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 23:45:04 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: swsusp@lister.fornax.hu, CaT <cat@zip.com.au>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [Swsusp] Re: [FIX, please test] Re: 2.5.70-bk16 - nfs interferes with s4bios suspend
Date: Mon, 16 Jun 2003 09:41:46 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, swsusp-devel@lists.sourceforge.net
References: <20030613033703.GA526@zip.com.au> <20030615183111.GD315@elf.ucw.cz> <20030616001141.GA364@zip.com.au>
In-Reply-To: <20030616001141.GA364@zip.com.au>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306160941.46575.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 June 2003 08:11, CaT wrote:
> On Sun, Jun 15, 2003 at 08:31:11PM +0200, Pavel Machek wrote:
> > >  stopping tasks failed (2 tasks remaining)
> > > Suspend failed: Not all processes stopped!
> > > Restarting tasks...<6> Strange, rpciod not stopped
> >
> > This should fix it... Someone please test it.
>
> I didn't have any actual nfs mounts at the time but I tried it
> with an otherwise similar system. It went through, got to freeing
> memory, showed me a bunch of fullstops being drawn and then went
> into an endless BUG loop. All I could pick out (after many a moment
> of staring) was 'schedule in atmoic'.
>
> I'll do a proper test with a console cable present in a few days. I
> can't atm cos I'm not on the same network and don't have a 2nd
> computer to hook up the null-modem cable to.
>
> Pre-empt is on btw.

I tested swsusp ex 2.5 BK tree - it is is broken. 

Looks something like: Writing data to swap (2273 pages): .<3>bad: scheduling while atomic!
and call traces.

Have a look at the thread on LKML around June 4: 
IDE Power Management (Was: software suspend in 2.5.70-mm3)

I'll wait for Nigel's 2.5 port

Regards
Michael
-- 
Powered by linux-2.5.70-mm3, compiled with gcc-2.95-3 because it's rock solid
                
My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Learning 2.5 kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 serial and ide drivers, ACPI, S3

The 2.5 kernel could use your usage. More info on setting up 2.5 kernel at 
http://www.codemonkey.org.uk/post-halloween-2.5.txt



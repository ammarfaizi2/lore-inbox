Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbULPSPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbULPSPd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbULPSPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:15:33 -0500
Received: from relay02.pair.com ([209.68.5.16]:4616 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S261457AbULPSP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:15:27 -0500
X-pair-Authenticated: 66.134.112.218
Subject: Re: [ACPI] [ACPI][2.6.10-rc3][SUSPEND] S3 mode - Cannot resume
	from PCI devices
From: Daniel Gryniewicz <dang@fprintf.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
In-Reply-To: <20041214181819.GB5267@openzaurus.ucw.cz>
References: <200412100315.21725.shawn.starr@rogers.com>
	 <20041214110648.GA2291@elf.ucw.cz>
	 <1103039717.10857.53.camel@athena.fprintf.net>
	 <20041214181819.GB5267@openzaurus.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Dec 2004 13:15:24 -0500
Message-Id: <1103220924.23829.8.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 19:18 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > This isn't a nice regression.
> > > 
> > > So what was the last kernel where it worked?
> > 
> > For me, 2.6.9-rc4.  I've tried every -rc and -mm since, and it cannot
> > resume.  (I get no video on resume, even with 2.6.9-rc4, until X
> 
> Okay, perhaps you are lucky, diff between 2.6.9-rc4 and 2.6.9
> should be fairly small. Could you find which changeset is responsible?
> bkcvs should be really usefull here.
> 
> 				Pavel

So, I started out by building 2.6.9 to test it failed.  It failed.
Then, I started binary searching between 2.6.9-rc4 and 2.6.9, and worked
my way all the way back up to 2.6.9 with it working.  I'm now running
the current CVS as of yesterday, with no problems, and with suspend and
resume working.  I have no idea what changed between the original build
of 2.6.9 that failed, and the final build that worked, but it would
appear to have been something that was my fault.

Now if I could only get 10-rc4-ck1 to not hang on boot...

Daniel

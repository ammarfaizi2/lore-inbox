Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUGRV2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUGRV2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 17:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUGRV2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 17:28:46 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:35479 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264526AbUGRV2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 17:28:42 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.8-rc1: Possible SCSI-related problem on dual Opteron w/ NUMA
Date: Sun, 18 Jul 2004 23:38:05 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200407171826.03709.rjwysocki@sisk.pl> <200407172109.38088.rjwysocki@sisk.pl> <200407181448.14614.rjwysocki@sisk.pl>
In-Reply-To: <200407181448.14614.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407182338.05282.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 of July 2004 14:48, R. J. Wysocki wrote:
> Andi,
>
> On Saturday 17 of July 2004 21:09, R. J. Wysocki wrote:
> > On Saturday 17 of July 2004 20:12, Andi Kleen wrote:
> > > On Sat, Jul 17, 2004 at 06:26:03PM +0200, R. J. Wysocki wrote:
> > > > I got this on a dual Opteron system on 2.6.8-rc1 with the latest
> > > > x86-64 patchset from Andi:
> > >
> > > Does it happen with x86_64-2.6.8-1 too ?
> >
> > It did not happen when I was running that kernel, but I had only run it
> > for a couple of times.  It generally does not happen with this one
> > either. It's happened only once and I reported it immediately.  But ...
>
> [snip]
>
> I had this problem again this morning.  I was unpacking the kernel tarball
> to /dev/sda8 and it went south (the tarball had been partially unpacked
> before the partition was remounted r-o).  Then, I got back to 2.6.7 and ran
> fsck - now it found some errors (obviously) and fixed them.  Next (on
> 2.6.7), I unpacked the kernel to /dev/sda8 (again) and compiled the
> 2.6.8-rc2.  I ran it, unpacked the kernel to /dev/sda8 (again) and compiled
> it - everything worked.  Then, I applied your patch on top of the newly
> created 2.6.8-rc2 tree and compiled the kernel.  After installing and
> running it I tried to unpack the kernel to /dev/sda8 (again) and it went
> south, so I got back to the "plain" 2.6.8-rc2, ran fsck and fixed the
> partition, unpacked the kernel to /dev/sda8 - and it all worked.
>
> So, it seems, there's something in your patch that causes this misbehavior.

To clarify: in the above "your patch" means "x86_64-2.6.8rc1-1".  I should 
have called it by name.  Sorry for the confusion,

rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267724AbTGaThn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 15:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269036AbTGaThn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 15:37:43 -0400
Received: from imap.gmx.net ([213.165.64.20]:45779 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267724AbTGaThm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 15:37:42 -0400
Date: Fri, 1 Aug 2003 01:07:41 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-mm2
Message-ID: <20030731193741.GA1618@home.woodlands>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030730223810.613755b4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730223810.613755b4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> [31-07-2003 14:52]:
> 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm2/
> 
> . CPU scheduler changes
> 
> . Several changes to the synaptics and PS/2 drivers.  People who have had
>   problems with keyboards and mice, please test and report.
> 
> . Lots of other things, mainly bugfixes.

I have noticed that while the system remains responsive when there is 
heavy CPU load alone, the unresponsiveness comes when there is heavy disk
i/o. In light of this, I subjected my system to the following tests :

1) Untarred linux-2.6.0-test2.tar.bz2 (To create a stream of  writes)
2) did a `find / -name "foobar" -print` as root (To create a stream of reads)
3) bzip2'ed a 30 MB file to 3.2 MB ( this ensures 100 % CPU usage).

All the above were working on the same disk.

As the above three things were going on, I was browsing, playing music
on xmms, reading a pdf file in acrobat and generally switching between
windows.

I did the above test on both 2.6.0-test2-mm1 + O11int + O11.1int ( no
O11.2 int) and on 2.6.0-test2-mm2. I find that mm1 + O11 patches are
better than mm2. The music never skipped on mm1, while it did on
mm2. Also, overall resposiveness of the various windows was better on
mm1.

However, when I did a `rpm --rebuilddb` on mm1 + O11int patches, I
still got quite severe skipping toward the end of the 8 min process. I
could not repeat the skipping again, even on the same kernel, because
I guess there was not much rebuilding to do again..

If there are tools which I can use to produce helpful numbers, please
let me know. I will post the required numbers ASAP. 

Also, if you have any other tests which I could perform to create
heavy disk I/O, please let me know about that too.

Regards,

  - Apurva

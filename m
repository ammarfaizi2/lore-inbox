Return-Path: <linux-kernel-owner+w=401wt.eu-S932119AbWLOAsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWLOAsZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWLOAsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:48:25 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:2436 "EHLO
	mcr-smtp-001.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932110AbWLOAsX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:48:23 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Linux 2.6.20-rc1
Date: Fri, 15 Dec 2006 00:48:25 +0000
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612142113.41135.s0348365@sms.ed.ac.uk> <20061214212055.GR5010@kernel.dk>
In-Reply-To: <20061214212055.GR5010@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612150048.25552.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 December 2006 21:20, Jens Axboe wrote:
> On Thu, Dec 14 2006, Alistair John Strachan wrote:
> > Hi Jens,
> >
> > On Thursday 14 December 2006 20:48, Jens Axboe wrote:
> > > On Thu, Dec 14 2006, Jens Axboe wrote:
> > > > > I'll do that if nobody comes up with anything obvious.
> > > >
> > > > If you can just test 2.6.19-git1, then we'll know if it's the SG_IO
> > > > patch again.
> > >
> > > Actually, you should test 2.6.19-git1 with this patch applied as well.
> >
> > 2.6.19-git1 with FUJITA Tomonori's bio-leak fix doesn't break, and
> > hddtemp continues to work fine:
> >
> > [root] 21:10 [~] hddtemp /dev/sda /dev/sdb /dev/sdc /dev/sdd
> > /dev/sda: WDC WD2500KS-00MJB0: 29°C
> > /dev/sdb: WDC WD2500KS-00MJB0: 27°C
> > /dev/sdc: Maxtor 6B200M0: 28°C
> > /dev/sdd: Maxtor 6B200M0: 26°C
> >
> > I've added the strace results to the URL previously posted, with the
> > config.
>
> Then it is likely the sata updates, SG_IO is off the hook.

I bisected all the way down to 0e75f9063f5c55fb0b0b546a7c356f8ec186825e, which 
git reckons is the culprit. I wasn't able to revert this commit to test, 
because it has conflicts.

Any ideas?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWBJAcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWBJAcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWBJAcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:32:16 -0500
Received: from mail.gmx.net ([213.165.64.21]:20955 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750869AbWBJAcP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:32:15 -0500
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: a couple of oopses with 2.6.14
Date: Fri, 10 Feb 2006 01:32:11 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org
References: <200602091934.20732.bernd.schubert@pci.uni-heidelberg.de> <20060209152744.00de43f6.akpm@osdl.org>
In-Reply-To: <20060209152744.00de43f6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602100132.12120.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew and James,

thanks for your help.


On Friday 10 February 2006 00:27, Andrew Morton wrote:
> Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de> wrote:
> > Hi,
> >
> > here's a machine that works perfectly with 2.6.11, but gives oopes during
> > the boot process with 2.6.14. Unfortunately its everytime another oops.
> > Usually I would assume its a memory issue, but the machine really works
> > perfectly with 2.6.11.
>
> scsi has had a few problems with error recovery lately.
>
> > We will run a memory test over the weekend, but so far I don't believe it
> > will find anything.
>
> No, I wouldn't bother doing that.

Ok.

>
> > ------------- example 1
> > ------------------------------------------------------
> >
> > [4294676.669000] scsi0 : ata_piix
> > [4294676.831000] ATA: abnormal status 0x7F on port 0xE407
>
> So we have a sata problem.  It triggered two scsi bugs.  The first (a
> warning) is being fixed.  I don't know if the second has been fixed.

I'm not sure if its only a sata problem, I saw several of other oopses, one 
was related to Firewire/scsi (ok, could be a consequence of the previous sata 
problem), one came from bluesmoke (external patch) and some of them I 
couldn't associate to anything (but those I couldn't also capture via 
netconsole).


>
> Can you test 2.6.15?
>

Sure, I will test 2.6.15 this evening. I will also enable most debugging 
information for this testkernel, ok?


Thanks,
	Bernd


PS: For production we unfortunately can't use 2.6.15 - reiserfs trouble (well, 
I could try to revert commit 5fa8ad644faa114c4190484ac50e15236fc7cdd9, but 
I'm still waiting for an offical statement of the reiserfs poeple) and 
Win4Lin patches are available up to 2.6.14 only (its the PC of our secretary 
and she really wouldn't like that ;) ).

-- 
Bernd Schubert
PCI / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbULLWe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbULLWe4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbULLWe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:34:56 -0500
Received: from mailfe08.swip.net ([212.247.154.225]:21676 "EHLO
	mailfe08.swip.net") by vger.kernel.org with ESMTP id S261954AbULLWex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:34:53 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: Re: acpi_power_off issue in 2.6.10-rc2-mm1
From: Alexander Nyberg <alexn@dsv.su.se>
To: Daniel Andersen <anddan@linux-user.net>
Cc: Dave Jones <davej@redhat.com>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       linux-kernel@vger.kernel.org
In-Reply-To: <419AFE1A.1090905@linux-user.net>
References: <Pine.LNX.4.61.0411162301460.5829@student.dei.uc.pt>
	 <20041116235009.GG8674@redhat.com>  <419AFE1A.1090905@linux-user.net>
Content-Type: text/plain
Date: Sun, 12 Dec 2004 23:34:35 +0100
Message-Id: <1102890875.661.13.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-17 at 08:30 +0100, Daniel Andersen wrote:
> Dave Jones wrote:
> > On Tue, Nov 16, 2004 at 11:10:03PM +0000, Marcos D. Marado Torres wrote:
> > 
> >  > In 2.6.10-rc2 and previous kernels acpi_power_off allways worked fine, but 
> >  > in
> >  > 2.6.10-rc2-mm1 when I do 'halt' all runs fine, the last message 
> >  > "acpi_power_off
> >  > called. System is going to power off" (something like this, I don't recall
> >  > ^-^;) appears, but then the machine just doesn't power off.
> >  > 
> >  > This is happening with an ASUS M3N laptop, I guess that it's a problem
> >  > somewhere in
> >  > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm1/broken-out/bk-acpi.patch
> >  > When I get some time I'll take a deeper look into it...
> > 
> > This one has been around for a while. It's been plagueing me since 2.6.8,
> > though its interesting that you only see it happening recently.
> > 
> > My attempts to debug it led to the bug disappearing when I added
> > instrumentation to the kernel.  On my Compaq Evo, it does power off
> > eventually, though it takes about a minute after that last
> > acpi_power_off message.
> > 
> > There are bugs open on this in bugme.osdl.org, and bugzilla.redhat.com
> > 
> > http://bugme.osdl.org/show_bug.cgi?id=3642
> > https://bugzilla.redhat.com/beta2/show_bug.cgi?id=acpi_power_off
> > 
> I'm having the same problem with 2.6.10-rc2-mm1. I did not have the 
> problem with 2.6.10-rc1-mm5 and earlier as I remember. Will look into it.

Have you tried waiting a bit longer - say five minutes. I just took a
look at this and it appears that both my x86 computers do actually turn
off after a while, acpi_power_off appears to make quite deep call chains
and abuse some slow functions.

It would be good to know if it actually works (although taking way too
long time) for you.

Thanks
Alexander


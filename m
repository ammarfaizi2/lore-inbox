Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSFNANa>; Thu, 13 Jun 2002 20:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317856AbSFNAN3>; Thu, 13 Jun 2002 20:13:29 -0400
Received: from host194.steeleye.com ([216.33.1.194]:10245 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317855AbSFNAN3>; Thu, 13 Jun 2002 20:13:29 -0400
Message-Id: <200206140013.g5E0DQR25561@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Dave Jones <davej@suse.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andrey Panin <pazke@orbita1.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: NEW SUBARCHITECTURE FOR 2.5.21] support for NCR voyager 
 (3/4/5xxx series)
In-Reply-To: Message from Dave Jones <davej@suse.de> 
   of "Fri, 14 Jun 2002 01:17:09 +0200." <20020614011709.E16772@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Jun 2002 20:13:26 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de said:
> Would it make sense for the subarchs to use the generic code where
> possible, and only reimplement it's own (for eg) apic.c as and when it
> actually *needs* to be different ? 

That is really the way I've implemented it.  The only PC specific file in the 
generic directory is mpparse.c (since neither visws nor voyager has an MP 
compliant bios).  All the shareable files are kept in `kernel' and activated 
by config options.

I can certainly move mpparse.c back to kernel and add an extra (non user 
visible) config option.

> Sounds quite logical. What does the current patches you have do ? I've
> not had chance to look at them yet. 

It creates directories `generic' for the standard pc and `visws'.  The voyager 
patch creates a `voyager' directory.  Alternatively, these could be `mach-pc', 
`mach-visws' and `mach-voyager'.

James





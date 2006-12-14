Return-Path: <linux-kernel-owner+w=401wt.eu-S932755AbWLNUGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbWLNUGh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbWLNUGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:06:37 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:3003 "EHLO
	mcr-smtp-001.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932755AbWLNUGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:06:36 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Bill Nottingham <notting@redhat.com>
Subject: [PATCH] Fix help text for CONFIG_ATA_PIIX
Date: Thu, 14 Dec 2006 20:06:49 +0000
User-Agent: KMail/1.9.5
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <200612141714.55948.s0348365@sms.ed.ac.uk> <200612141832.50587.s0348365@sms.ed.ac.uk> <20061214195314.GC10955@nostromo.devel.redhat.com>
In-Reply-To: <20061214195314.GC10955@nostromo.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612142006.49406.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 December 2006 19:53, Bill Nottingham wrote:
> Alistair John Strachan (s0348365@sms.ed.ac.uk) said:
> > > > Is it possible to use pata_mpiix (or pata_oldpiix) with an ICH4 IDE
> > > > controller and boot off it?
> > >
> > > ata_piix (the SATA/PATA driver) deals with the ICH4. pata_mpiix is
> > > specifically for the Intel MPIIX laptop chipset and pata_oldpiix
> > > explicitly for the original PIIX chipset and none of the later ones.
> >
> > Correct me if I'm wrong, but SATA wasn't available on ICH4. Only 5 and
> > greater. The kernel help text agrees with me.
> >
> > My IDE controller usually works with CONFIG_BLK_DEV_PIIX; I was
> > interested in using your pata_xxx drivers in replacement, assuming there
> > was support.
>
> pata_xxx is for older PIIX, not ICH4. ICH* is handled by ata_piix, which
> can drive both SATA *and* PATA in the new kernels. 

Thanks for clarifying Bill, and sorry Alan. ata_piix does indeed work 
correctly. The help text is a bit confusing:

config ATA_PIIX
        tristate "Intel PIIX/ICH SATA support"
        depends on PCI
        help
          This option enables support for ICH5/6/7/8 Serial ATA.
          If PATA support was enabled previously, this enables
          support for select Intel PIIX/ICH PATA host controllers.

"Enabled previously"?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

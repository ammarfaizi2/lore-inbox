Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTJJBGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTJJBGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:06:30 -0400
Received: from codepoet.org ([166.70.99.138]:39065 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S262745AbTJJBG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:06:29 -0400
Date: Thu, 9 Oct 2003 19:06:30 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Greg Stark <gsstark@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>, Philippe Lochon <plochon.n0spam@free.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: P4C800E-Dlx: ICH5/S-ATA and Intel Pro onboard network incompatibility ?
Message-ID: <20031010010629.GA20873@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Greg Stark <gsstark@mit.edu>, Jeff Garzik <jgarzik@pobox.com>,
	Philippe Lochon <plochon.n0spam@free.fr>,
	linux-kernel@vger.kernel.org
References: <3F7EDCDD.7090500@free.fr> <20031004180338.GA24607@codepoet.org> <20031004192733.GA30371@gtf.org> <20031004195342.GA25328@codepoet.org> <20031005201638.GB4259@codepoet.org> <87r81l9a9u.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r81l9a9u.fsf@stark.dyndns.tv>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 09, 2003 at 09:00:45PM -0400, Greg Stark wrote:
> 
> Erik Andersen <andersen@codepoet.org> writes:
> 
> > It turns out it was locking up while loading up the ide-scsi
> > kernel module.  I have
> 
> Oooh, ooh, me too!
> 
> And I'm not even using libata (I don't think?). 
> I'm just using stock 2.4.23-pre4.
> 
> This is a P4P800 with one SATA drive and two PATA drives.
> 
> The system works fine as long as ide-scsi isn't loaded
> (and noflushd doesn't spin down any drives).
> 
> Getting ide-scsi working is pretty soon on my todo list as it means being able
> to play DVDs and use the cdrecorder.

Do check your /proc/interrupts though.  With my P4P800 I found
that when set to Enhanced mode, and when ide-scsi was carefully
avoided, I was still getting a storm of interrupts that were
doing rather bad things for system performance.  Can you check if
you are also seeing the same thing?  i.e. does the interrupt line
with your ide controller(s) on it show bazillions of interrupts?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

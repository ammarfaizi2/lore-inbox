Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270061AbUJHQGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270061AbUJHQGI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270052AbUJHQCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:02:45 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:3017 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270053AbUJHQBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:01:45 -0400
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4166B37D.8030701@rtr.ca>
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i
	nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165A4
	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca>	<4
	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>
		<20041007221537.A17712@infradead.org>	<1097241583.2412.15.camel@mulgrave> 
	<4166AF2F.6070904@rtr.ca> <1097249266.1678.40.camel@mulgrave> 
	<4166B37D.8030701@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Oct 2004 11:01:34 -0500
Message-Id: <1097251299.1928.56.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 10:34, Mark Lord wrote:
> If those locks are not needed, the scsi.c maintainer really should
> nuke'em.

I think you can safely assume he has more important things to do.

> > Really, I suppose, libata should provide the interfaces for doing this
> > work for emulated commands.
> 
> Well, after this driver submission work is done with,
> that's next on my list.  Right now libata doesn't have
> the right interface for easy sharing of such functions.

Not emulating an INQUIRY properly via SG_IO isn't acceptable since it's
a mandatory command.

libata does all this correctly.  I strongly suggest you find a way to
share the code rather than trying to reinvent it yourself.  But anyway,
if you want to know how it should work, look in libata-scsi.c

James



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWHaF3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWHaF3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 01:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbWHaF3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 01:29:33 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:58483 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751050AbWHaF3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 01:29:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OTVd4n7gN7wR0xNod1EBqSOEEOntc7uStLDJmhCqGnWw4kzpXE/4ZTGJ1mYDXlOcl02HlR1dYWTXMfjSmAvtZX5V3sNnaIFz04sKUVoYVXb0I+PdhafBFO4eSZFf5KltmT/ELne3QOtZ4EWWWKSVDBlhyRoUetR0rOo0a+5H3d4=  ;
Message-ID: <20060831052931.133.qmail@web31806.mail.mud.yahoo.com>
Date: Wed, 30 Aug 2006 22:29:31 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] aic94xx: Increase can_queue and cmds_per_lun
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>,
       Konrad Rzeszutek <konrad@darnok.org>
In-Reply-To: <1156965920.7701.13.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- James Bottomley <James.Bottomley@SteelEye.com> wrote:
> On Wed, 2006-08-30 at 12:04 -0700, Luben Tuikov wrote:
> > > --- a/drivers/scsi/aic94xx/aic94xx_init.c
> > > +++ b/drivers/scsi/aic94xx/aic94xx_init.c
> > > @@ -71,7 +72,7 @@ static struct scsi_host_template aic94xx
> > >       .change_queue_type      = sas_change_queue_type,
> > >       .bios_param             = sas_bios_param,
> > >       .can_queue              = 1,
> > > -     .cmd_per_lun            = 1,
> > > +     .cmd_per_lun            = 2,
> > 
> > Why 2?  Why not 3?  If you can set this to 3, then why not 4?
> > But if you can set it to 4, why not 5?
> > 
> > This value should also be dynamically set, it should depend on
> > the type of LU and it shouldn't be present in the host template.
> > (But that's an architectural argument which leads nowhere on lsml.)
> 
> actually, cmd_per_lun is pretty much a vestigial variable.  It's used
> for the initial queue depth before the driver decides to turn on TCQ.
> Thus, since the non-tagged depth should always only be 1, the only
> useful value to set it to is 1.

Who cares?



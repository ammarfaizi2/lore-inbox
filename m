Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275244AbTHGJtj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275251AbTHGJtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:49:39 -0400
Received: from smtp.terra.es ([213.4.129.129]:5307 "EHLO tfsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S275244AbTHGJti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:49:38 -0400
From: CASINO_E <CASINO_E@teleline.es>
To: linux-kernel@vger.kernel.org
Reply-To: casino_e@terra.es
Message-ID: <1b4bd91b8e12.1b8e121b4bd9@teleline.es>
Date: Thu, 07 Aug 2003 11:49:36 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: es
Subject: Re: [PATCH] Merge the changes from siimage 2.4.22-pre9 to
 2.6.0-test2
X-Accept-Language: es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote...
> > 	if(is_sata(hwif))
> > 	{
> > +		drive->id->hw_config |= 0x6000;
> > 		if(strstr(drive->id->model, "Maxtor"))
> > 			return 3;
> > 		return 4;
> >  	}
> 
> We never check the cable bits for SATA so this is a no-op

Alan,

Without this, in 2.4.22-pre10-ac1, ide_ata66_check() in ide-iops.c
returns 1. This causes, for example, that hdparm -i shows only udma
modes 0 to 2 (although the drive has been set to udma6) and refuses to
set any value above udma2 with an ugly "Speed warnings UDMA 3/4/5 is
not functional".

I do not understand the ide subsystem enough (I should say "at all"),
but maybe there are other implications...

Eduardo.




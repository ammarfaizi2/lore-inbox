Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272820AbTG3LoI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272822AbTG3LoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:44:08 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:62068 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S272820AbTG3LoF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:44:05 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01BF8F58@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Disk performance degradation
Date: Wed, 30 Jul 2003 13:43:40 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comparative vmstat -d 1 could help as well

-----Message d'origine-----
De : Andrew Morton [mailto:akpm@osdl.org]
Envoyé : mercredi 30 juillet 2003 12:55
À : Stefano Rivoir
Cc : lista1@telia.com; linux-kernel@vger.kernel.org
Objet : Re: Disk performance degradation


Stefano Rivoir <s.rivoir@gts.it> wrote:
>
> Voluspa wrote:
> 
> > On 2003-07-29 12:00:06 Stefano Rivoir wrote:
> > 
> > 
> >>Is there something I'm missing?!
> > 
> > 
> > No, you are not ;-) You can reclaim some speed by doing a "hdparm -a
> > 512". See thread for explanation (it's the borked value for readahead):
> 
> Thanks for the hint. This seems to make things a little better, but I'm
> still far away from 2.4 performances. I thought that anticipatory sched
> could be part of the problem, and booting with elevator=deadline
> does a little better... but using 2.4 is completely another thing.
> By the way, -a 512 vs -a 8 is a kernel "change" or an hdpam one?

What makes you think it is a disk performance problem at all?  All we know
is that KDE applications take longer to start up, yes?

How much memory is in that machine?  Can you run a `vmstat 1' trace during
the "slow" operations?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

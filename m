Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbUBSCdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267711AbUBSCdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:33:43 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:61587 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267687AbUBSCd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:33:28 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jochen Becker <jochen@linux.it4free.de>
Subject: Re: 2.6.3
Date: Thu, 19 Feb 2004 03:39:41 +0100
User-Agent: KMail/1.5.3
References: <1077154272.3471.3.camel@jbdesktop> <20040218174630.05253fd6.akpm@osdl.org> <1077155738.3471.7.camel@jbdesktop>
In-Reply-To: <1077155738.3471.7.camel@jbdesktop>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402190339.41053.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 of February 2004 02:55, Jochen Becker wrote:
> hello recievers
> andrew say to me that i have to send this to you.

Hi,

> Jochen
>
> orig mail :
>
> Am Do, den 19.02.2004 schrieb Andrew Morton um 02:46:
> > Jochen Becker <jochen@linux.it4free.de> wrote:
> > > Hello Linus / Andrew
> > >
> > > i have now compiled the kernel 2.6.3 and have problems
> > > a) the time out for the ide driver sil serial ata is to long when their
> > > is no harddisc installed. the kernel detects 2 times for 10 secounds
> >
> > Please report this to
> >
> > Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> and
> > Jeff Garzik <jgarzik@pobox.com> and
> > linux-kernel@vger.kernel.org

Thanks for the report.  Unfortunately this is a known issue
(http://bugzilla.kernel.org/show_bug.cgi?id=1009) and solution
requires adding proper SATA detection to IDE driver which I won't do
(cause there is libata SATA driver and libata SiI driver now).
Though you can workaround it using "idex=noprobe" kernel parameter.

--bart


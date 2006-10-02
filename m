Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWJBUWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWJBUWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWJBUWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:22:10 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:37281 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964968AbWJBUWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:22:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=tcdYrWmT+HpqIhw04lgu8WmXq/gxWnllIRu8Twl9zqeDgJ3Z2m2iGtQJK+hwA7tcKbtR4gJCf2z6Y7YfieahG9wKJocN97IhcwWgBveIaSuQG3T4cMVktsHT5y4NvzAkDkTrjB7f3K52hS4vxgAs4Zzera7ouI/TeJPN9eSym7k=  ;
From: David Brownell <david-b@pacbell.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 2.6.18-git] ide-cs (CompactFlash) driver, rm irq warning
Date: Mon, 2 Oct 2006 13:22:02 -0700
User-Agent: KMail/1.7.1
Cc: B.Zolnierkiewicz@elka.pw.edu.pl,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200610020902.20030.david-b@pacbell.net> <200610021158.59886.david-b@pacbell.net> <1159821812.8907.66.camel@localhost.localdomain>
In-Reply-To: <1159821812.8907.66.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021322.02912.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 1:43 pm, Alan Cox wrote:
> Ar Llu, 2006-10-02 am 11:58 -0700, ysgrifennodd David Brownell:
> > The IRQ handler seems to be drivers/ide/ide-io.c::ide_intr() and
> > comments there reflect the expectation that it handle shared IRQs.
> 
> I was more worried what the pcmcia side may be up to

The relevant flag appears to be ignored inside drivers/pcmcia except
to trigger the annoying message ... leaving the remaining potential
for side effects inside the old IDE stack, which would already be
showing bug symptoms if there were any.


> but yes this should 
> get dealt with and -mm will find any horrors fast.
> 
> Acked-by: Alan Cox <alan@redhat.com>
> 

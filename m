Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVFWKO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVFWKO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVFWKLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:11:15 -0400
Received: from general.keba.co.at ([193.154.24.243]:31574 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S262613AbVFWKAp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 06:00:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCMCIA: Statically linked CF card driver?
Date: Thu, 23 Jun 2005 12:00:44 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F36732324A@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCMCIA: Statically linked CF card driver?
Thread-Index: AcV3yiKGSGArjdIPSDavsyGiKetNmgAD1NBg
From: "kus Kusche Klaus" <kus@keba.com>
To: "Dominik Brodowski" <linux@dominikbrodowski.net>
Cc: <linux-pcmcia@lists.infradead.org>, <dahinds@users.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dominik Brodowski [mailto:linux@dominikbrodowski.net] 
> Hi,
> 
> - use 2.6.12-mm1, and build all you need into the kernel
> - in drivers/pcmcia/ds.c , remove the following block:
> 
>                 /* also, FUNC_ID matching needs to be 
> activated by userspace
>                  * after it has re-checked that there is no 
> possible module
>                  * with a prod_id/manf_id/card_id match.
>                  */
>                 if (!dev->allow_func_id_match)
>                         return 0;
> 
> - it should(tm) work then... though I haven't and can't try it myself.

Thanks, I'll try it.

> > * Any chance to boot from it?
> 
> > * It would be nice to be able to replace the CF 
> >   without rebooting.
> 
> I'm not sure whether these two aspects exclude each other.

We don't need them at the same time:

* Usually, the system boots from flash, 
  and the CF is used for data transfer 
  (and hence should be changeable).

* In case of emergency (when the system in flash got messed up), 
  or for the first-time flash,
  it would be nice to be able to boot from CF.
  In that case, the CF will not be removed in flight!

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com

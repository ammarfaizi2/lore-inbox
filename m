Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271506AbTGQPle (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271504AbTGQPle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:41:34 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:25265 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S271506AbTGQPlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:41:31 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Jeff Garzik <jgarzik@pobox.com>, ricardo.b@zmail.pt
Subject: Re: SET_MODULE_OWNER
Date: Thu, 17 Jul 2003 17:56:17 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net> <3F16C190.3080205@pobox.com>
In-Reply-To: <3F16C190.3080205@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307171756.19826.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 July 2003 17:32, Jeff Garzik wrote:
> Ricardo Bugalho wrote:
> > Hi all,
> >   most net device drivers have replaced MOD_INC/DEC_USE_COUNT with
> > SET_MODULE_OWNER but SET_MODULE_OWNER doesn't do nothing.
> >   Therefore, those modules (though I can only vouch for 8139too) always
> > report 0 use. Some people that had "modprobe -r" in their cronttab found
> > it quite annoying.
> >   I'd guess that there's a good reason for why struct net_device doesn't
> > have .owner field and why this happens. Can someone be so kind to point
> > it
> > out?
>
> struct net_device does have an owner field, and SET_MODULE_OWNER
> obviously _does_ do something.

That's not correct for 2.5.x anymore...
Have a look at Changeset 1.1167 from davem.

It removed the owner field about 9 weeks ago. That was the time where 
SET_MODULE_OWNER became a NOP...

> If your interface is up, your net driver's module refcount is greater
> than zero.

Well, as I looked now my netdevice is up, but its reference count is at 0, 
too!

  Thomas Schlichter

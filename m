Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265361AbUEZIpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265361AbUEZIpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 04:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbUEZIpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 04:45:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:64773 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265361AbUEZIpj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 04:45:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Don't return void types from void functions.
Date: Wed, 26 May 2004 11:38:41 +0300
X-Mailer: KMail [version 1.4]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405260606.i4Q66dXB023475@hera.kernel.org> <40B43913.7010207@pobox.com>
In-Reply-To: <40B43913.7010207@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200405261138.41008.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 May 2004 09:28, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> > diff -Nru a/drivers/net/tokenring/olympic.c
> > b/drivers/net/tokenring/olympic.c ---
> > a/drivers/net/tokenring/olympic.c	2004-05-25 23:06:49 -07:00 +++
> > b/drivers/net/tokenring/olympic.c	2004-05-25 23:06:49 -07:00 @@ -1806,7
> > +1806,7 @@
> >
> >  static void __exit olympic_pci_cleanup(void)
> >  {
> > -	return pci_unregister_driver(&olympic_driver) ;
> > +	pci_unregister_driver(&olympic_driver) ;
> >  }
>
> Can we make gcc error out when it finds this?

AFAIK new C++ standard allows this syntax.

typedef int opaque;

opaque f();
opaque g() { return f(); }

Now imagine we need to change
-typedef int opaque;
+typedef void opaque;
-- 
vda

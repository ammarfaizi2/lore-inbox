Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSJNNOD>; Mon, 14 Oct 2002 09:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261552AbSJNNOD>; Mon, 14 Oct 2002 09:14:03 -0400
Received: from hermes.domdv.de ([193.102.202.1]:44562 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S261427AbSJNNOC>;
	Mon, 14 Oct 2002 09:14:02 -0400
Message-ID: <3DAAC457.3040402@domdv.de>
Date: Mon, 14 Oct 2002 15:19:19 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Theewara Vorakosit <g4465018@pirun.ku.ac.th>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS root on 2.4.18-14
References: <Pine.GSO.4.44.0210142012520.5993-100000@pirun.ku.ac.th>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030903080205000602040205"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030903080205000602040205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Theewara Vorakosit wrote:
> Dear All,
>     I use Red Hat 8.0 and kernel 2.4.18-14, which come from redhat
> distribution. I want create a NFS-root kernel to build a diskless linux
> using NFS root. I select "IP kernel level configuration-> BOOTP, DHCP",
> NFS root support. I boot client using my kernel, it does not requrest for
> an IP address. It try to mount NFS root immediately. Do I forget
> something?
If you try to boot from a floppy that was created like "dd if=vmlinuz 
of=/dev/fd0" you will need the attached patch. Alan Cox however told me 
that the ability to boot without boot manager (e.g. lilo) will 
eventually go away.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------030903080205000602040205
Content-Type: text/plain;
 name="ip.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ip.patch"

diff -rNu linux/net/ipv4/ipconfig.c linux-custom/net/ipv4/ipconfig.c
--- linux/net/ipv4/ipconfig.c	2002-09-27 14:05:32.000000000 +0200
+++ linux-custom/net/ipv4/ipconfig.c	2002-09-27 14:57:01.000000000 +0200
@@ -107,7 +107,7 @@
  */
 int ic_set_manually __initdata = 0;		/* IPconfig parameters set manually */
 
-int ic_enable __initdata = 0;			/* IP config enabled? */
+int ic_enable __initdata = 1;			/* IP config enabled? */
 
 /* Protocol choice */
 int ic_proto_enabled __initdata = 0

--------------030903080205000602040205--


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265599AbSKACJ0>; Thu, 31 Oct 2002 21:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265601AbSKACJZ>; Thu, 31 Oct 2002 21:09:25 -0500
Received: from fmr01.intel.com ([192.55.52.18]:64737 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265599AbSKACJY>;
	Thu, 31 Oct 2002 21:09:24 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC8B8@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: =?iso-8859-15?Q?=27Dieter_N=FCtzel=27?= <Dieter.Nuetzel@hamburg.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       "Alan Cox (E-mail)" <alan@lxorguk.ukuu.org.uk>
Subject: RE: 2.5.45: AIC7XXX_BUILD_FIRMWARE=y is broken
Date: Thu, 31 Oct 2002 18:15:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-15"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> make -f scripts/Makefile.build obj=drivers/scsi/aic7xxx
> make[3]: *** No rule to make target 
> `drivers/scsi/aic7xxx/aix7xxx_seq.h', 
> needed by `driver
> s/scsi/aic7xxx/aic7xxx_reg.h'.  Stop.

That was a typo I introduced and the fix somehow did not get
to Alan's tree [AFAIK]. Replace that aix7xxx by aic7xxx.

--- drivers/scsi/aic7xxx/Makefile	31 Oct 2002 23:28:26 -0000
+++ drivers/scsi/aic7xxx/Makefile	1 Nov 2002 00:18:34 -0000
@@ -41,7 +41,7 @@
 	$(obj)/aicasm/aicasm -I$(obj) -r $(obj)/aic7xxx_reg.h \
 				 -o $(obj)/aic7xxx_seq.h $(src)/aic7xxx.seq
 
-$(obj)/aic7xxx_reg.h: $(obj)/aix7xxx_seq.h
+$(obj)/aic7xxx_reg.h: $(obj)/aic7xxx_seq.h
 
 $(obj)/aicasm/aicasm: $(src)/aicasm/*.[chyl]
 	$(MAKE) -C $(src)/aicasm

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSLFQXt>; Fri, 6 Dec 2002 11:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbSLFQXt>; Fri, 6 Dec 2002 11:23:49 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:37075 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261950AbSLFQXs>; Fri, 6 Dec 2002 11:23:48 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.20 fails to build with aic7xxx
Date: Fri, 6 Dec 2002 17:31:13 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
MIME-Version: 1.0
Message-Id: <200212061730.16703.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_1WHP0NRYLGWF8XE2NH3F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_1WHP0NRYLGWF8XE2NH3F
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Ralf,

> yacc -d -b aicasm_gram aicasm_gram.y
> aicasm_gram.y:921.21: parse error, unexpected ":", expecting ";" or "|"
> aicasm_gram.y:936.2-5: $$ of critical_section_start' has no declared ty=
pe
> aicasm_gram.y:938.2-5: $$ of critical_section_start' has no declared ty=
pe
> make[6]: *** [aicasm_gram.h] Error 1
the fix is imho the easiest fix anyone ever done on earth ;)

attached!

ciao, Marc


--------------Boundary-00=_1WHP0NRYLGWF8XE2NH3F
Content-Type: text/x-diff;
  charset="us-ascii";
  name="175_aic7xxx-build-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="175_aic7xxx-build-fix.patch"

--- linux-old/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y	2002-09-27 23:25:52.000000000 +0200
+++ linux-wolk4/drivers/scsi/aicasm_gram.y	2002-12-06 17:28:03.000000000 +0100
@@ -917,6 +917,7 @@
 		cs->begin_addr = instruction_ptr;
 		in_critical_section = TRUE;
 	}
+;
 
 critical_section_end:
 	T_END_CS ';'

--------------Boundary-00=_1WHP0NRYLGWF8XE2NH3F--


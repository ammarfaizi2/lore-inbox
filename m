Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbREQUIK>; Thu, 17 May 2001 16:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262106AbREQUIA>; Thu, 17 May 2001 16:08:00 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:4601 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S262103AbREQUHt>; Thu, 17 May 2001 16:07:49 -0400
Message-ID: <9678C2B4D848D41187450090276D1FAE0635F02F@FMSMSX32>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'hch@caldera.de'" <hch@caldera.de>, thockin@sun.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.4 failure to compile
Date: Thu, 17 May 2001 11:33:26 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try setting CONFIG_AIC7XXX_BUILD_FIRMWARE=n as a workaround.

-----Original Message-----
From: hch@caldera.de [mailto:hch@caldera.de]
Sent: Thursday, May 17, 2001 2:04 PM
To: thockin@sun.com
Cc: Linux kernel; root@chaos.analogic.com
Subject: Re: Linux-2.4.4 failure to compile


In article <3B040C80.C2A7BC6@sun.com> you wrote:
> "Richard B. Johnson" wrote:
>> 
>> Hello;
>> 
>> I downloaded linux-2.4.4. The basic kernel compiles but the aic7xxx
>> SCSI module that I require on some machines, doesn't.

> The aic7xxx assembler requiring libdb1 is a bungle.  Getting the headers
> for that right on various distros is not easy.  Add to that it requires
> YACC, when most people have bison (yes, a shell script is easy to make,
but
> not always an option). 

If make wants to use yacc but you don't have it, it's probably a mistake
in the make(1) configuration - the Makefile uses implicit rules and
distributions not having yacc should not call it in make's implicit rules.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


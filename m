Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266319AbSLCWKg>; Tue, 3 Dec 2002 17:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbSLCWKg>; Tue, 3 Dec 2002 17:10:36 -0500
Received: from fmr02.intel.com ([192.55.52.25]:1993 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266319AbSLCWKf>; Tue, 3 Dec 2002 17:10:35 -0500
Message-ID: <004a01c29b19$d9800a50$62d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: <trelane@digitasaru.net>, <linux-kernel@vger.kernel.org>
References: <20021203220928.GA3024@digitasaru.net>
Subject: Re: [ide-scsi] "structure has no member named `tag'"
Date: Tue, 3 Dec 2002 14:18:04 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a discussion on this at
http://marc.theaimsgroup.com/?t=103861087100001&r=1&w=2

To get past this you can just change the line to compare ->name instead ->tag until the real fix lands.

    -rustyl
----- Original Message -----
From: "Joseph Pingenot" <trelane@digitasaru.net>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 03, 2002 2:09 PM
Subject: [ide-scsi] "structure has no member named `tag'"


> Found this on 2.5.50+bk3
>
>


gcc -Wp,-MD,drivers/scsi/.ide-scsi.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno
-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix
include -DMODULE   -DKBUILD_BASENAME=ide_scsi -DKBUILD_MODNAME=ide_scsi   -c -o drivers/scsi/ide-scsi.o drivers/scsi/ide-scsi.c
> drivers/scsi/ide-scsi.c: In function `should_transform':
> drivers/scsi/ide-scsi.c:767: structure has no member named `tag'
> make[2]: *** [drivers/scsi/ide-scsi.o] Error 1
> make[1]: *** [drivers/scsi] Error 2
> make: *** [drivers] Error 2
>
>
> --
> Joseph===============================================trelane@digitasaru.net
> "I use Linux and it makes me feel safer knowing exactly what security
>  problems my boxen are facing. If I wanted filtered information or a public
>  relations a** kissing, I'd use Microsoft products." --dattaway, on /.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


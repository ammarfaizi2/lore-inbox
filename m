Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135709AbRDSVAu>; Thu, 19 Apr 2001 17:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135714AbRDSVAb>; Thu, 19 Apr 2001 17:00:31 -0400
Received: from HIC-SR1.hickam.af.mil ([131.38.214.15]:14215 "EHLO
	hic-sr1.hickam.af.mil") by vger.kernel.org with ESMTP
	id <S135709AbRDSVAR>; Thu, 19 Apr 2001 17:00:17 -0400
Message-ID: <4CDA8A6D03EFD411A1D300D0B7E83E8F6972BF@FSKNMD07.hickam.af.mil>
From: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
To: "'Hai Xu'" <xhai@CLEMSON.EDU>, linux-kernel@vger.kernel.org
Subject: RE: A little problem.
Date: Thu, 19 Apr 2001 21:00:28 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sounds to me like you have the wrong source in /usr/src/linux there is a
module you can install, or you can do it as I normally would...

obtain kernel source for 2.2.18 from ftp.kernel.org and put it in "/usr/src"
(/pub/linux/kernel/v2.2/linux-2.2.18.tar.bz2)

remove the symlink in /usr/src
"rm -f /usr/src/linux"

extract the new kernel source tree
"cd /usr/src ; tar xfI linux-2.2.18.tar.bz2"

rename the directory to kernel version and create symlink (for consistancy)
"mv linux linux-2.2.18 ; ln -s linux-2.2.18 linux"


	Sam Bingner
	PACAF CSS/SCHE
	Contractor RSIS
	DSN	315 449-7889
	COMM	808 449-7889


-----Original Message-----
From: Hai Xu [mailto:xhai@CLEMSON.EDU]
Sent: Thursday, April 19, 2001 10:47 AM
To: linux-kernel@vger.kernel.org
Subject: A little problem.kernel


Dear all,

I have a question about the kernel used by the RedHat. I am using Redhat 7.0
and upgrade the Linux Kerenl from their original 2.2.16 to 2.2.18. But when
I compile some modules, it said my kernel is 2.4.0. I check the
/usr/include/linux/version.h as follows, found that it shows I am using
Kernel 2.4.0.

#include <linux/rhconfig.h>
#if defined(__module__smp)
#define UTS_RELEASE "2.4.0-0.26smp"
#else
#define UTS_RELEASE "2.4.0-0.26"
#endif
#define LINUX_VERSION_CODE 132096
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))


 But when I "cat /proc/version", it will give me:

Linux version 2.2.18-rtl (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 Thu Apr 5 23:10:12 EDT 2001

So I am totally confused by the RedHat. So could you please tell me how to
solve this problem?

I just want to use the 2.2.18 without the 2.4.0. I did not install this one,
I also do not know where this one comes from.

Thanks in advance.
Hai Xu



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

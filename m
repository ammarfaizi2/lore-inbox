Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRADKiT>; Thu, 4 Jan 2001 05:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbRADKiK>; Thu, 4 Jan 2001 05:38:10 -0500
Received: from colorfullife.com ([216.156.138.34]:18436 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129406AbRADKh7>;
	Thu, 4 Jan 2001 05:37:59 -0500
Message-ID: <3A545287.4C73C9E5@colorfullife.com>
Date: Thu, 04 Jan 2001 11:37:59 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: isabellf@sympatico.ca, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-Prerelease :smp_num_cpus undefined while compiling without smp 
 for  Athlon
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look at include/linux/smp.h: on SMP, it includes <asm/smp.h>, on UP it
contains a

#define smp_num_cpus	1

I assume that someone directly includes <asm/smp.h>.

Try to add a 

#ifndef __LINUX_SMP_H
#error Found it!
#endif

to the beginning of <asm-alpha/smp.h>

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132021AbRCVOeK>; Thu, 22 Mar 2001 09:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132032AbRCVOeA>; Thu, 22 Mar 2001 09:34:00 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:65295 "HELO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S132021AbRCVOdp>; Thu, 22 Mar 2001 09:33:45 -0500
Reply-To: <frey@cxau.zko.dec.com>
From: "Martin Frey" <frey@scs.ch>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: kernel_thread vs. zombie
Date: Thu, 22 Mar 2001 06:32:52 -0800
Message-ID: <004c01c0b2dc$fa6ab3e0$90600410@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010322114927.14509@mailhost.mipsys.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>How do I force a kernel thread to always be a child of init and never
>become a zombie ?
>
>I do call daemonize at the beginning of the thread (as it won't do
>anything with files, signals or whatever), but that doesn't 
>seem to be enough.
>
Have a look at:
http://www.scs.ch/~frey/linux/kernelthreads.html
I have an example there that starts and stops kernel threads
from init_module and never produced a zombie.
I use the same code also to start threads from ioctl and it
works for me. I tested it on UP and SMP, Intel and Alpha,
2.2.18 and 2.4.2.

Regards,

Martin

-- 
Supercomputing Systems AG       email: frey@scs.ch
Martin Frey                     web:   http://www.scs.ch/~frey/
at Compaq Computer Corporation  phone: +1 603 884 4266
ZKO2-3P09, 110 Spit Brook Road, Nashua, NH 03062


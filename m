Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132948AbRDJH3R>; Tue, 10 Apr 2001 03:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132949AbRDJH3H>; Tue, 10 Apr 2001 03:29:07 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:1007 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S132948AbRDJH25> convert rfc822-to-8bit; Tue, 10 Apr 2001 03:28:57 -0400
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Andi Kleen <ak@suse.de>
cc: Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        linux-kernel@vger.kernel.org
Message-ID: <C1256A2A.0028E607.00@d12mta07.de.ibm.com>
Date: Tue, 10 Apr 2001 09:27:00 +0200
Subject: Re: No 100 HZ timer !
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Just how would you do kernel/user CPU time accounting then ?  It's
currently done
>on every timer tick, and doing it less often would make it useless.
This part is architecture dependent. For S/390 I choose to do a "STCK" on
every
system entry/exit. Dunno if this can be done on other architectures too, on
 S/390
this is reasonably cheap (one STCK costs 15 cycles). That means the
kernel/user CPU
time accounting is MUCH better now.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com



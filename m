Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132045AbRDJOov>; Tue, 10 Apr 2001 10:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132121AbRDJOos>; Tue, 10 Apr 2001 10:44:48 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:52394 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S132045AbRDJOog> convert rfc822-to-8bit; Tue, 10 Apr 2001 10:44:36 -0400
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: David Schleef <ds@schleef.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        linux-kernel@vger.kernel.org
Message-ID: <C1256A2A.0050C6A0.00@d12mta07.de.ibm.com>
Date: Tue, 10 Apr 2001 16:42:35 +0200
Subject: Re: No 100 HZ timer !
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>BTW. Why we need to redesign timers at all? The cost of timer interrupt
>each 1/100 second is nearly zero (1000 instances on S/390 VM is not common
>case - it is not reasonable to degradate performance of timers because of
>this).
The cost of the timer interrupts on a single image system is neglectable,
true. As I already pointed out in the original proposal we are looking
for a solution that will allow us to minimize the costs of the timer
interrupts when we run many images. For us this case is not unusual and
it is reasonable to degrade performance of a running system by a very
small amount to get rid of the HZ timer. This proposal was never meant
to be the perfect solution for every platform, that is why it is
configuratable with the CONFIG_NO_HZ_TIMER option.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com



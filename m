Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266150AbRGTGIW>; Fri, 20 Jul 2001 02:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbRGTGIM>; Fri, 20 Jul 2001 02:08:12 -0400
Received: from 194.38.82.urbanet.ch ([194.38.82.193]:45068 "EHLO
	internet.dapsys.com") by vger.kernel.org with ESMTP
	id <S266150AbRGTGIC> convert rfc822-to-8bit; Fri, 20 Jul 2001 02:08:02 -0400
From: Edouard Soriano <e_soriano@dapsys.com>
Date: Fri, 20 Jul 2001 06:05:50 GMT
Message-ID: <20010720.6055000@dap21.dapsys.ch>
Subject: 1GB system working with 64MB - Solved
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Problem solved.
This is one top output:
 5:47pm  up 21 min,  2 users,  load average: 0.99, 0.70, 0.48
110 processes: 109 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.1% user,  2.4% system,  0.0% nice, 96.4% idle
CPU1 states:  0.1% user,  5.4% system,  0.0% nice, 93.5% idle
Mem:   906424K av,  904296K used,    2128K free,   19808K shrd,   20956K 
buff
Swap:  514040K av,   17176K used,  496864K free                  710672K 
cached

The system is using now 906MB rather than 1024, but at this time of the
day I am quite happy comapred with the 64MB used before.
Next step will be to go on 2.4.x
Thanks


Hello Folks,

Environment: linux 2.2.16smp
RedHat 7.0

I am setting up a system with 1GB RAM recongized by the
BIOS during power-on procedure.

This system having troubles, I set a top command and
with surprise I got this  status:

  4:33pm  up  4:42,  3 users,  load average: 4.18, 2.01, 1.09
125 processes: 123 sleeping, 2 running, 0 zombie, 0 stopped
CPU0 states:  9.1% user,  9.0% system,  8.0% nice, 80.1% idle
CPU1 states: 20.0% user,  6.1% system, 20.1% nice, 72.0% idle
Mem:    63892K av,   62480K used,    1412K free,   15076K shrd,    5192K 
buff
Swap:  514040K av,  260556K used,  253484K free                   11804K 
cached

My problem are the 63892K

I remember there is a solution to turn around this problem
forcing LILO to configure 1GB saying, I think but not 
sure:

append='memory=1024'

I searched in the lilo doc for memory parameter definition, but
as being coverd by append parameter I found nothing.

Question 1:
Do you have an idea about the reason Linux is using 64MB ?

Question 2:
Is this append command correct to turn out this problem ?

Question 3:
Where can I found informations about append variables wich
are related in fact with modules parameters ?
How to find on source code which module will read the 
memory parameter ?

Thanks in advance.

Bye

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135785AbRDTCsd>; Thu, 19 Apr 2001 22:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135787AbRDTCs0>; Thu, 19 Apr 2001 22:48:26 -0400
Received: from supelec.supelec.fr ([160.228.120.192]:29959 "EHLO
	supelec.supelec.fr") by vger.kernel.org with ESMTP
	id <S135785AbRDTCsM>; Thu, 19 Apr 2001 22:48:12 -0400
Message-ID: <3ADFA34D.80D8BEE9@supelec.fr>
Date: Fri, 20 Apr 2001 04:47:41 +0200
From: Francois Cami <francois.cami@supelec.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Vibol Hou <vhou@khmer.cc>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 
In-Reply-To: <NDBBKKONDOBLNCIOPCGHIEHBGDAA.vhou@khmer.cc>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vibol Hou wrote:
> 
> Hi,
> 
> I'm using 2.4.4-pre3 and get this message occasionally when the system is
> loaded:
> 
> Apr 17 16:10:12 omega kernel: eth0: Too much work in interrupt, status e401.
> Apr 17 16:10:12 omega kernel: eth0: Too much work in interrupt, status e401.

I got that one too, PC is ASUS P2B-DS with two PII-350, 384MB RAM,
3C905B.
I've tried 3C905C to no avail.
The e401 status seems to be that there is too much load on the card to
be treated in the 20 (2.2.17) or 32 (2.2.19, 2.4.x) loops of the
interruption
check routine (stop/hit me if i'm wrong please). 
I think we should try (MM. Donald Becker or Andrew Norton, 
is this a Bad Thing ?) to change max_interrupt_work (3c59x.c, row 171)
to 64
or maybe even higher. Haven't had the guts to try on the production
machine
right now =)

> The nic is a 3Com 3c905B. Is this a bad thing?

I heard they work fine... 

François Cami
There And Back Again

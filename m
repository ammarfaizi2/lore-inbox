Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268165AbTB1WN1>; Fri, 28 Feb 2003 17:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268174AbTB1WN1>; Fri, 28 Feb 2003 17:13:27 -0500
Received: from vsmtp3.tin.it ([212.216.176.223]:21496 "EHLO smtp3.cp.tin.it")
	by vger.kernel.org with ESMTP id <S268165AbTB1WN0>;
	Fri, 28 Feb 2003 17:13:26 -0500
Message-ID: <3E5FE165.C8BABD4@libero.it>
Date: Fri, 28 Feb 2003 23:23:33 +0100
From: Abramo Bagnara <abramo.bagnara@libero.it>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: [Bug 420] New: Divide by zero 
 (/proc/sys/net/ipv4/neigh/DEV/base_reachable_time)
References: <27440000.1046453828@[10.10.2.4].suse.lists.linux.kernel> <p733cm86yv0.fsf@amdsimf.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> "Martin J. Bligh" <mbligh@aracnet.com> writes:
> >
> >     echo 0 > /proc/sys/net/ipv4/neigh/DEV/base_reachable_time
> >
> >   But neigh_rand_reach_time() divide by its argument.
> >
> >     unsigned long neigh_rand_reach_time(unsigned long base)
> >     {
> >       return (net_random() % base) + (base>>1);
> >     }
> 
> Don't do that then. The sysctl is root-only. There are lots of ways to
> break the system by writing bogus values into root only configuration
> options. That is why they are root only
> 
> I would close the report as WONTFIX.

Don't this argument bring to the weird equality:

root user == infallible guy

IMHO the "if you make a typo you crash the machine" should be avoided
(at least when feasible without drawbacks).

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

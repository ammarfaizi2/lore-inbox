Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbTESWDH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTESWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:03:07 -0400
Received: from 213-97-199-90.uc.nombres.ttd.es ([213.97.199.90]:37608 "HELO
	fargo") by vger.kernel.org with SMTP id S263132AbTESWDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:03:05 -0400
Date: Tue, 20 May 2003 00:20:52 +0200
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: Hugo Mills <hugo-lkml@carfax.org.uk>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: e100 driver
Message-ID: <20030519222052.GA9598@fargo>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20030519211248.GA7633@fargo> <20030519213318.GB1605@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030519213318.GB1605@carfax.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugo,

On May 19 at 10:33:18, Hugo Mills wrote:
> > <31>May 19 09:05:42 kernel: hw tcp v4 csum failed
> > <31>May 19 09:11:11 kernel: icmp v4 hw csum failure
> 
>    I get this, too, on two recently-purchased machines. I suspect that
> the new revs of the chips are the cause -- my kernel doesn't seem to
> know about many of the device IDs on this board:

Not in my case :(, i'm using a not very recent intel ethernet card:

00:0c.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)

>    Other than the odd csum failures (average of 1-2 a day on each
> box), it all seems to work perfectly.

I was getting a lot more, look:

[huma@fargo] [~] % grep csum /var/log/messages|grep "May 19"| wc -l
    443
[huma@fargo] [~] % grep csum /var/log/messages|grep "May 18"| wc -l
    486
[huma@fargo] [~] % grep csum /var/log/messages|grep "May 17"| wc -l
    425
[huma@fargo] [~] % grep csum /var/log/messages|grep "May 16"| wc -l
    953
[huma@fargo] [~] % grep csum /var/log/messages|grep "May 15"| wc -l
   1023
[huma@fargo] [~] % grep csum /var/log/messages|grep "May 14"| wc -l
    911

I've been a long time without noticing this problem, but looking casually
for another reason at the logs get me to finding these checksum errors hell ;))


-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra

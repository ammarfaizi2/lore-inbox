Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbTHVAMX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTHVAMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:12:23 -0400
Received: from www.13thfloor.at ([212.16.59.250]:65259 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262943AbTHVAMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:12:21 -0400
Date: Fri, 22 Aug 2003 02:12:33 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Jens Gecius <jens@gecius.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 smp irq balance
Message-ID: <20030822001233.GA32143@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Jens Gecius <jens@gecius.de>,
	linux-kernel@vger.kernel.org
References: <878yporqgy.fsf@maniac.gecius.de> <1061468471.27494.1.camel@laptop.fenrus.com> <87vfsrq8vg.fsf@maniac.gecius.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87vfsrq8vg.fsf@maniac.gecius.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 06:21:39PM +0200, Jens Gecius wrote:
> Arjan van de Ven <arjanv@redhat.com> writes:
> 
> >> irqs seem not to be distributed between cpus, having one to handle all
> >> (even while building kernel on both cpus (according to gkrell), the
> >> numbers for the second cpu don't change.
> >
> > just install and run the irqbalance daemon from:
> > http://people.redhat.com/arjanv/irqbalance
> 
> I did. Didn't change anything. The numbers are the same - the only
> CPU2 irq increasing is LOC. Any other hints?

I remember some strange case (somewhere around 2.4.18,
yes I know you are running 2.6.0 whatever) where I needed
to set the smp_affinity manually after boot, otherwise
the second cpu would not receive any interrupts on some
dual athlon system ...

echo ff >/proc/irq/xx/smp_affinity 

did the trick, everything else was working as expected ...

just a weird idea, don't blame me if it actually works ;)

best,
Herbert

> -- 
> Tschoe,                http://gecius.de/gpg-key.txt - Fingerprint:
>  Jens                  1AAB 67A2 1068 77CA 6B0A  41A4 18D4 A89B 28D0 F097
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

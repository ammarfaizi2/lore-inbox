Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131731AbQKYUyo>; Sat, 25 Nov 2000 15:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131738AbQKYUy0>; Sat, 25 Nov 2000 15:54:26 -0500
Received: from slc39.modem.xmission.com ([166.70.9.39]:58892 "EHLO
        flinx.biederman.org") by vger.kernel.org with ESMTP
        id <S131731AbQKYUyU>; Sat, 25 Nov 2000 15:54:20 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mrbig@sneaker.sch.bme.hu, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <E13zk0b-0001CU-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Nov 2000 12:46:48 -0700
In-Reply-To: Alan Cox's message of "Sat, 25 Nov 2000 18:25:07 +0000 (GMT)"
Message-ID: <m17l5rx2af.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > benn compiled into the kernel, and not as a module) always gave the
> > errors:
> > 
> > eth0: Transmit timed out: status 0050  0090 at 134704418/134704432 
> > eth0: Trying to restart the transmitter...
> 
> Known problem. This one might be fixed in current 2.2.18pre. SOme people
> see it some dont

I have another data point on this problem.
I have seen it most with 2.4.0-test9.  But I'll look at 2.2.18pre.
I can trigger this bug fairly reliably by warm booting, several times
in a row.  With my linux warm booting directly into linux code triggers this
one fairly reliably :)  Also putting another nick in seems to help
trigger it as well.

The 2.4.0-testxxx watchdog seems eventually to handle this case 
but it takes 1/2 hour or so to actually kick in and reset the card.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

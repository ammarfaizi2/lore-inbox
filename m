Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQK3W6E>; Thu, 30 Nov 2000 17:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQK3W5y>; Thu, 30 Nov 2000 17:57:54 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:44044 "HELO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S129183AbQK3W5f>; Thu, 30 Nov 2000 17:57:35 -0500
Date: Thu, 30 Nov 2000 17:26:58 -0500 (EST)
From: Phillip Ezolt <ezolt@perf.zko.dec.com>
To: axp-list@redhat.com
Cc: rth@twiddle.net, Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org,
        clinux@zk3.dec.com, wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
In-Reply-To: <20001201004049.A980@jurassic.park.msu.ru>
Message-ID: <Pine.OSF.3.96.1001130171941.32335D-100000@perf.zko.dec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan,
	We dug a little deeper, and think that we found the problem. 

The error occurs if we have over 1024 MB of memory in the machine. 
If we have less than 1024MB, the machine behaves correctly. 
(This is a 600Mhz Digital Personal Workstation)

Once again, the 2.2 kernel in RH 7.0 behaves properly. 

I'll give test12-pre3 a try and see if it fixes things.

Thanks,
--Phil

Compaq:  High Performance Server Division/Benchmark Performance Engineering 
---------------- Alpha, The Fastest Processor on Earth --------------------
Phillip.Ezolt@compaq.com        |C|O|M|P|A|Q|        ezolt@perf.zko.dec.com
------------------- See the results at www.spec.org -----------------------

On Fri, 1 Dec 2000, Ivan Kokshaysky wrote:

> On Thu, Nov 30, 2000 at 03:02:42PM -0500, Phillip Ezolt wrote:
> > Qlogic SCSI support seems broken on 2.4.0-test11 on a Miata (Digital Personal WorkStation 600au).
> > 
> > When starting up, we get a machine check after initialing the qlogic SCSI code. 
> 
> Try test12-pre3 - there is the new PCI init stuff. It works (to some degree)
> on as1000a with the same qlogic scsi.
> 
> Ivan.
> 
> 
> 
> _______________________________________________
> Axp-list mailing list
> Axp-list@redhat.com
> https://listman.redhat.com/mailman/listinfo/axp-list
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

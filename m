Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQK3WN3>; Thu, 30 Nov 2000 17:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbQK3WNT>; Thu, 30 Nov 2000 17:13:19 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:43527 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S130229AbQK3WNI>; Thu, 30 Nov 2000 17:13:08 -0500
Message-ID: <22F662CDC53ED411B65700805F31DE1C135911@exccop-01.dmo.cpqcorp.net>
From: "Mathiasen, Torben" <Torben.Mathiasen@COMPAQ.COM>
To: "Rival, Frank" <FRIVAL@ZK3.DEC.COM>,
        "Ezolt, Phillip" <ezolt@perf.zko.dec.com>
Cc: ink@jurassic.park.msu.ru, rth@twiddle.net, axp-list@redhat.com,
        "Estabrook, Jay" <jestabro@pdgsrv.mro.cpqcorp.net>,
        linux-kernel@vger.kernel.org, clinux@ZK3.DEC.COM,
        wcarr@perf.zko.dec.com
Subject: RE: Alpha SCSI error on 2.4.0-test11
Date: Thu, 30 Nov 2000 21:42:27 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its probaly due to the semaphore changes that went in to test11 by
Richard Henderson. scsi_wait_req will grab one on entry. Did test10
work for you on Alpha?

Regards,

Torben Mathiasen

> -----Original Message-----
> From: Rival, Frank 
> Sent: 30. november 2000 21:37
> To: Ezolt, Phillip
> Cc: ink@jurassic.park.msu.ru; rth@twiddle.net; axp-list@redhat.com;
> Estabrook, Jay; linux-kernel@vger.kernel.org; clinux@zk3.dec.com;
> wcarr@perf.zko.dec.com
> Subject: Re: Alpha SCSI error on 2.4.0-test11
> 
> 
> Hi Phil,
> 
> Phillip Ezolt wrote:
> 
> > Hi All,
> > 
> > Qlogic SCSI support seems broken on 2.4.0-test11 on a Miata 
> (Digital Personal WorkStation 600au).
> > 
> > When starting up, we get a machine check after initialing 
> the qlogic SCSI code. 
> > 
> > Using the Alpha kgdb, we figured out that the code is dying 
> in scsi_wait_request().
> 
> Wow, I'm impressed!  I didn't realize that kgdb worked on 
> Alpha...Were 
> you using the remote kgdb?  (You can answer me offline to save 
> bandwidth.)  This would be a _huge_ help in trying to figure 
> out why my 
> Wildfire^WGS160 is crashing with the DISCONTIGMEM code that I 
> stole from 
> Jay and have been hacking on.
> 
> Speaking of that system, it has two QLogic adapters in it 
> (both 1040Bs, 
> like the Miata), and they are working just fine under 2.4.0-test11 
> (obviously, without my changes ;).  It looks like it's probably the 
> platform code that's busted.  I can't remember...are those Pyxis or 
> CIA?  Anyway, could this have something to do with the PCI & 
> PCI bridge 
> work that Richard and Ivan just submitted?
> 
> - Pete
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

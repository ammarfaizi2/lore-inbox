Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbTAWDcY>; Wed, 22 Jan 2003 22:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbTAWDcY>; Wed, 22 Jan 2003 22:32:24 -0500
Received: from [207.103.86.132] ([207.103.86.132]:63426 "EHLO
	EXCHANGE.ccgroupnet.com") by vger.kernel.org with ESMTP
	id <S264836AbTAWDcX> convert rfc822-to-8bit; Wed, 22 Jan 2003 22:32:23 -0500
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: normal
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
Date: Wed, 22 Jan 2003 22:41:32 -0500
Message-ID: <54F2B44015EC2A4B84BB935F462E8C0AD88B5C@exchange.ccgroupnet.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
thread-index: AcLChmagEp3u/xB3QlqKJWtn7JtF9wACn77g
From: "Gabriel Rosenkoetter" <grosen@cc3.com>
To: "Jacek Radajewski" <jacek@usq.edu.au>
Cc: <linux-poweredge@dell.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, Jacek, you've got a bum IDE controller or disk (at a glance, been
a while since I knew or cared about Linux kernel internals).

Either that or, based on this:

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Error (expand_objects): cannot stat(/lib/aacraid.o) for aacraid
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Warning (map_ksym_to_module): cannot match loaded module ext3 to a
unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module aacraid to a
unique module object.  Trace may not be reliable.

You've got a /lib out of sync with kernel world.

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Wednesday, January 22, 2003 9:20 PM
> To: Jacek Radajewski
> Cc: Seth Mos; linux-poweredge@dell.com; linux-kernel@vger.kernel.org
> Subject: Re: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
> 
> 
> Jacek Radajewski wrote:
> > is the network card really the problem ?  I don't want to 
> be replacing all my network cards if the problem is elsewhere 
> .... if you can understand the oops message please, please, 
> please let me know where the problem is ...
> 
> > Trace; c01ac741 <start_request+1a1/210>
> > Trace; c01acacc <ide_do_request+29c/2f0>
> > Trace; c01acf99 <ide_intr+129/160>
> > Trace; f897f2f0 <.data.end+6cf1/????>
> > Trace; c010a61e <handle_IRQ_event+5e/90>
> > Trace; c010a852 <do_IRQ+c2/110>
> > Trace; c0106e60 <default_idle+0/40>
> > Trace; c0105000 <_stext+0/0>
> > Trace; c010d058 <call_do_IRQ+5/d>
> > Trace; c0106e60 <default_idle+0/40>
> > Trace; c0105000 <_stext+0/0>
> > Trace; c0106e8c <default_idle+2c/40>
> > Trace; c0106ef4 <cpu_idle+24/30>
> 
> 
> nope, that trace has nothing to do with the network stack or 
> net card...
> 
> 	Jeff
> 
> 
> 
> _______________________________________________
> Linux-PowerEdge mailing list
> Linux-PowerEdge@dell.com
> http://lists.us.dell.com/mailman/listinfo/linux-poweredge
> Please read the FAQ at http://lists.us.dell.com/faq or search 
> the list archives at http://lists.us.dell.com/htdig/
> 

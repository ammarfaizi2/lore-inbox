Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbTEAVCv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 17:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTEAVCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 17:02:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16060 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262473AbTEAVCu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 17:02:50 -0400
Date: Thu, 1 May 2003 14:12:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christian =?ISO-8859-1?Q?Borntr=E4ger?= <linux@borntraeger.net>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.5.67 (and probably earlier)] /proc/dev/net doesnt show
 all net devices
Message-Id: <20030501141243.30c9c54e.rddunlap@osdl.org>
In-Reply-To: <200304291434.18272.linux@borntraeger.net>
References: <200304291434.18272.linux@borntraeger.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

On Tue, 29 Apr 2003 14:34:18 +0200 Christian Bornträger <linux@borntraeger.net> wrote:

| Summary: /proc/net/devices doesnt show all devices using cat. With dd all are 
| available.
| 
| I tested a kernels prior to 
| http://linus.bkbits.net:8080/linux-2.5/cset@1.797.156.3
| and it doesnt seem to have this problem.
| 
| If I do a 
| & cat /proc/net/dev
| Inter-|   Receive                                                |  Transmit
|  face |bytes    packets errs drop fifo frame compressed multicast|bytes    
| packets errs drop fifo colls carrier compressed
|     lo:     784      10    0    0    0     0          0         0      784      
| dummy0:       0       0    0    0    0     0          0         0        0       
|  tunl0:       0       0    0    0    0     0          0         0        0       
|   gre0:       0       0    0    0    0     0          0         0        0       
|   sit0:       0       0    0    0    0     0          0         0        0       
|   eth0: 1078024   19131    0    0    0     0          0         0  5696472   
|   eth1:536253967 10078459    0    0    0     0          0         0 3372254868 
| 
| I get net devices till eth1, but eth2 and hsi0 are available nevertheless.
| but if I do a 
| 
| & dd if=/proc/net/dev bs=4096
| Inter-|   Receive                                                |  Transmit
|  face |bytes    packets errs drop fifo frame compressed multicast|bytes    
| packets errs drop fifo colls carrier compressed
|     lo:    1036      13    0    0    0     0          0         0     1036      
| dummy0:       0       0    0    0    0     0          0         0        0       
|  tunl0:       0       0    0    0    0     0          0         0        0       
|   gre0:       0       0    0    0    0     0          0         0        0       
|   sit0:       0       0    0    0    0     0          0         0        0       
|   eth0: 1182386   18424    0    0    0     0          0         0 11838659   
|   eth1:30499791987 20594094    0    0    0     0          0         0 
|   eth2:184353121774 125264473    0    0    0     0          0         0 
|   hsi0:123569282529 3827611    0    0    0     0          0         0 
| 0+1 records in
| 0+1 records out
| 
| All net devices are shown.

Weird one to me.  Maybe someone else knows...

You were doing this test in an X terminal window, right?
and not on a text-only console?

The reason that I say that is that I can reproduce this problem on
2.5.68, but only in an xterm or similar window, but when I switch back
to a console, the entire device list is displayed.

???

--
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbUAUX7U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUAUX7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:59:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:219 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266146AbUAUX7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:59:19 -0500
Date: Wed, 21 Jan 2004 15:55:01 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1 + cset-20040120_0206] AHA152X building error
Message-Id: <20040121155501.4defb5b2.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58L.0401201043380.3210@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0401201043380.3210@alpha.zarz.agh.edu.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004 10:46:28 +0100 (CET) "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl> wrote:

| 
| I try to build this kernel and got this error:
| [...]
|   LD [M]  drivers/scsi/pcmcia/aha152x_cs.o
| drivers/scsi/pcmcia/aha152x_core.o(.init.text+0x0): In function `init_module':
| : multiple definition of `init_module'
| drivers/scsi/pcmcia/aha152x_stub.o(.init.text+0x0): first defined here
| ld: Warning: size of symbol `init_module' changed from 22 in drivers/scsi/pcmcia/aha152x_stub.o to 1212 in drivers/scsi/pcmcia/aha152x_core.o
| drivers/scsi/pcmcia/aha152x_core.o(.exit.text+0x0): In function `cleanup_module':
| : multiple definition of `cleanup_module'
| drivers/scsi/pcmcia/aha152x_stub.o(.exit.text+0x0): first defined here
| ld: Warning: size of symbol `cleanup_module' changed from 51 in drivers/scsi/pcmcia/aha152x_stub.o to 69 in drivers/scsi/pcmcia/aha152x_core.o
| make[3]: *** [drivers/scsi/pcmcia/aha152x_cs.o] Error 1
| make[2]: *** [drivers/scsi/pcmcia] Error 2
| make[1]: *** [drivers/scsi] Error 2
| make: *** [drivers] Error 2
| [...]


Are you sure that this is on 2.6.1 + changes?
I couldn't reproduce it there.

We do have this same problem in 2.4.25-preN.

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/

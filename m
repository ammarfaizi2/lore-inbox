Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132651AbRA3WXS>; Tue, 30 Jan 2001 17:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132752AbRA3WXI>; Tue, 30 Jan 2001 17:23:08 -0500
Received: from adsl-63-207-97-74.dsl.snfc21.pacbell.net ([63.207.97.74]:61169
	"EHLO nova.botz.org") by vger.kernel.org with ESMTP
	id <S132651AbRA3WW7> convert rfc822-to-8bit; Tue, 30 Jan 2001 17:22:59 -0500
Message-Id: <200101302222.OAA04184@nova.botz.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: Eric Molitor <emolitor@molitor.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Wavelan IEEE driver 
In-Reply-To: Message from Eric Molitor <emolitor@molitor.org> 
   of "Tue, 30 Jan 2001 14:38:50 CST." <Pine.LNX.4.10.10101301434420.3934-100000@www.llamacom.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 30 Jan 2001 14:22:43 -0800
From: Jurgen Botz <jurgen@botz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Molitor wrote:
> I updated the Wavelan IEEE driver from 2.3.50 so that it builds with 2.4.0
> (The 2.3.50 patch is available at
> http://www.fasta.fh-dortmund.de/users/andy/wvlan/ ) It works for me but
> I've heard there are issues with firmware 6.xx not initializing.
> 
> The patch against 2.4.0 is at http://www.molitor.org/wavelan

Actually the 1.0.6 driver included in the latest pcmcia-cs packages
works with 2.4.  Normally, when you build pcmcia-cs against a 2.4
kernel the modules are not built since they are supposed to be included
with the kernel... obviously not all of them are, however.  You can
force it to build the wvlan_cs driver by adding "wireless" to the
end of DIRS in the top-level makefile.  This will successfully build
the wvlan_cs module, which can then be inserted into a 2.4 kernel
and appears to work.  I did observe a problem with iwconfig dumping
core, but it seems to do its job before it dies, so this may be non-
critical.

The 1.0.6 driver is dated Dec-7-2000 and supports all the latest
"orinico" firmware revisions.  Somebody with the time and inclination
should probably integrate it into the main kernel source and send a
patch to Linus.

- Jürgen



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLTSp5>; Wed, 20 Dec 2000 13:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbQLTSpr>; Wed, 20 Dec 2000 13:45:47 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:6662 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129406AbQLTSpd>; Wed, 20 Dec 2000 13:45:33 -0500
Date: Wed, 20 Dec 2000 12:10:41 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: David Hinds <dhinds@valinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA modem (v.90 X2) not working with 2.4.0-test12 PCMCIA services
Message-ID: <20001220121041.A5183@vger.timpanogas.org>
In-Reply-To: <007101c067cc$0500c620$0b31a3ce@g1e7m6> <20001218154033.C11728@valinux.com> <20001219114614.A12948@valinux.com> <20001219154129.A1763@vger.timpanogas.org> <20001219135114.B13184@valinux.com> <20001219170516.A2039@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001219170516.A2039@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Tue, Dec 19, 2000 at 05:05:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 05:05:16PM -0700, Jeff V. Merkey wrote:

David,

Do you think there's a solution for this problem.  Sorry for bothering 
you again.  I'm available if you need some help retesting and fixes.

:-)

Jeff


> On Tue, Dec 19, 2000 at 01:51:14PM -0800, David Hinds wrote:
> > On Tue, Dec 19, 2000 at 03:41:29PM -0700, Jeff V. Merkey wrote:
> > > 
> > > On a related topic, the 3c575_cb driver on an IBM Thinkpad 765D is getting
> > > tx errors on the 2.2.18 kernel with PCMCIA services 3.1.22.
> > > 
> > > Card is a 3Com 3CCFE575BT Cyclone Cardbus Adapter.
> > > 
> > > Error is:
> > > 
> > > eth0:  transmit timed out, tx_status 00 status e000.
> > >   diagnostics net 0cc2 media a800 dma 000000a0
> > 
> > What host bridge is in the 765D?  Is it perhaps a TI 1131 rev 1, or
> > something else?  Also, try adding:
> > 
> 
> /proc/bus/pccard/00/info reports TI 1130 chipset.
> 
> >   module "3c575_cb" opts "down_poll_rate=0"
> 
> Adding this does not fix the problem, but does cause a little more
> error info to get printed.  Now in addition to the original message,
> I am also seeing:
> 
> eth0: Tx ring full, refusing to send buffer.
> 
> Looks like some type of interrupt problem.  I am available to assist 
> you in debugging this problem.
> 
> Jeff
> 
> > 
> > to /etc/pcmcia/config.opts and see if that makes any difference.
> > 
> > -- Dave
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

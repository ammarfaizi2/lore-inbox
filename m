Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131888AbQL1MHz>; Thu, 28 Dec 2000 07:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131996AbQL1MHp>; Thu, 28 Dec 2000 07:07:45 -0500
Received: from james.kalifornia.com ([208.179.68.97]:21561 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131888AbQL1MHg>; Thu, 28 Dec 2000 07:07:36 -0500
Message-ID: <3A4B25D1.127BFDFA@linux.com>
Date: Thu, 28 Dec 2000 03:36:49 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NETDEV WATCHDOG: eth0: transmit timed out
In-Reply-To: <3A4B234E.7A950A76@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------E6AF41DD2A0D8E76096CB2E1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E6AF41DD2A0D8E76096CB2E1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Manfred wrote:

> David wrote:
> >
> > Same old story, bugger still does it. Have to set the link down/up to
> > get it running again.
> >
> > 00:12.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
> > 20)
> >
>
> I missed your earlier mails, could you resend the details?
> I'm interested in the output from
>
>         tulip-diag -m -a -f
>
> before and after a link failure.
>
> I'm aware that the tulip drivers doesn't handle cable disconnects and
> reconnects with MII pnic cards. I have a patch for that problem, but it
> affects _all_ MII tulip cards, and thus it won't be included soon. If
> tulip-diag says "10mbps-serial", then you have run into that bug.
>
> --
>         Manfred

Here's the before, when the after happens..

# ./tulip-diag -m -a -f
tulip-diag.c:v2.04 9/26/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Lite-On 82c168 PNIC adapter at 0xf800.
Lite-On 82c168 PNIC chip registers at 0xf800:
  00008000 01ff0000 00450008 0118f000 0118f200 02660010 814c2202 0001ebef
  00000000 00000000 0118f2d0 01e3a88c 00000020 00000000 00000000 10000001
  00000000 00000000 f0041385 000000bf 609641e1 0118f110 00c99010 0001e978
  00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 Port selection is MII, full-duplex.
 Transmit started, Receive started, full-duplex.
  The Rx process state is 'Waiting for packets'.
  The Tx process state is 'Idle'.
  The transmit threshold is 72.
 MII PHY found at address 1, status 0x782d.
 MII PHY #1 transceiver registers:
   3000 782d 0040 6212 01e1 41e1 0003 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   5000 032b 0002 0046 0000 01cd 0100 0000
   003f f53e 0f00 ff00 002f 4000 80a0 000b.

This particular one is on a crossover @ 100 FD with a pcmcia tulip
card...which works fine.

The other machine I had reset tonight was on a crossover w/ cisco 3640
iirc.

-d


--------------E6AF41DD2A0D8E76096CB2E1
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------E6AF41DD2A0D8E76096CB2E1--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

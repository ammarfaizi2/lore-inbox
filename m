Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293669AbSCATow>; Fri, 1 Mar 2002 14:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293668AbSCATog>; Fri, 1 Mar 2002 14:44:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63497 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293669AbSCATnj>;
	Fri, 1 Mar 2002 14:43:39 -0500
Message-ID: <3C7FD9E7.BD26CABD@mandrakesoft.com>
Date: Fri, 01 Mar 2002 14:43:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Schaaf <bof@bof.de>
CC: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches.
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <3C7FD3C2.9674ADD7@mandrakesoft.com> <20020301204400.B24565@oknodo.bof.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Schaaf wrote:
> > Ben Greear wrote:
> > > --- linux-2.4.16/drivers/net/eepro100.c Mon Nov 12 18:47:18 2001
> > > +++ linux/drivers/net/eepro100.c        Tue Dec 18 11:36:11 2001
> > > @@ -510,12 +510,12 @@
> > >   static const char i82557_config_cmd[CONFIG_DATA_SIZE] = {
> > >          22, 0x08, 0, 0,  0, 0, 0x32, 0x03,  1, /* 1=Use MII  0=Use AUI */
> > >          0, 0x2E, 0,  0x60, 0,
> > > -       0xf2, 0x48,   0, 0x40, 0xf2, 0x80,              /* 0x40=Force full-duplex */
> > > +       0xf2, 0x48,   0, 0x40, 0xfa, 0x80,              /* 0x40=Force full-duplex */
> > >          0x3f, 0x05, };
> > >   static const char i82558_config_cmd[CONFIG_DATA_SIZE] = {
> > >          22, 0x08, 0, 1,  0, 0, 0x22, 0x03,  1, /* 1=Use MII  0=Use AUI */
> > >          0, 0x2E, 0,  0x60, 0x08, 0x88,
> > > -       0x68, 0, 0x40, 0xf2, 0x84,              /* Disable FC */
> > > +       0x68, 0, 0x40, 0xfa, 0x84,              /* Disable FC */
> > >          0x31, 0x05, };

> This patch, from all I know using it, does exactly one thing: it permits
> receiving (and sending) slightly larger frames, for setting the MTU on the
> base interface to 1504, so the VLAN interfaces themselves can run the
> normal 1500 byte MTU.

Thanks.

Can you be more specific?
Does this (a) set eepro100 h/w max mtu to 1504, or (b) enable h/w vlan
de-tagging, or (c) enable h/w support for non-standard frame sizes?
Any idea what the max h/w frame size is?

-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.

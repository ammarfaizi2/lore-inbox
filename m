Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129702AbRBOQLK>; Thu, 15 Feb 2001 11:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129723AbRBOQKu>; Thu, 15 Feb 2001 11:10:50 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:62225 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129702AbRBOQKp>;
	Thu, 15 Feb 2001 11:10:45 -0500
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
        becker@scyld.com
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <157828DC5517@vcnet.vc.cvut.cz>
From: Jes Sorensen <jes@linuxcare.com>
Date: 15 Feb 2001 17:09:47 +0100
In-Reply-To: "Petr Vandrovec"'s message of "Wed, 14 Feb 2001 16:54:22 MET-1"
Message-ID: <d366ic0vxw.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Petr" == Petr Vandrovec <VANDROVE@vc.cvut.cz> writes:

Petr> On 14 Feb 01 at 16:35, Jes Sorensen wrote:
>>  What else is sending out 802.3 frames these days? I really don't
>> care about IPX when it comes to performance.
>> 
>> I am just advocating that we optimize for the common case which is
>> DIX frames and not 802.3.

Petr> Pardon me, but IPX in 802.3 and IPX in DIX are exactly same
Petr> frames on wire, except that IPX/802.3 contains frame length in
Petr> bytes 0x0C/0x0D, while IPX/DIX contains 0x8137 here. They have
Petr> same length, and same length of media header, so I really do not
Petr> understand.

Petr> If you are talking about encapsulation which is known as
Petr> `ethernet_802.2' in IPX world, then it is true, it has odd bytes
Petr> in header. But nobody sane except Appletalk uses 802.2
Petr> now... Our Suns already died due to this couple of years ago ;-)

My point is that you rarely see Ethernet frames with 802.3 except for
places running IPX.

Jes

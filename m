Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129177AbRBIVnU>; Fri, 9 Feb 2001 16:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130048AbRBIVnL>; Fri, 9 Feb 2001 16:43:11 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:1040 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129849AbRBIVm4>;
	Fri, 9 Feb 2001 16:42:56 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ion Badulescu <ionut@moisil.cs.columbia.edu>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <200102080152.f181q6G17259@moisil.dev.hydraweb.com> <3A83017D.D84AD6B1@mandrakesoft.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 09 Feb 2001 22:42:08 +0100
In-Reply-To: Jeff Garzik's message of "Thu, 08 Feb 2001 15:28:45 -0500"
Message-ID: <d3d7crwn2n.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

Jeff> Donald Becker wrote:
>> On Tue, 16 Jan 2001, Jeff Garzik wrote: > * IA64 support (Jes) Oh,
>> and this is completely bogus.  This isn't a fix, it's a hack that
>> covers up the real problem.
>> 
>> The align-copy should *never* be required because the alignment
>> differs between DIX and E-II encapsulated packets.  The machine
>> shouldn't crash because someone sends you a different encapsulation
>> type!

The ia64 kernel has gotten mis aligned load support, but it's slow as
a dog so we really want to copy the packet every time anyway when the
header is not aligned. If people send out 802.3 headers or other crap
on Ethernet then it's just too bad.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280018AbRJ3Qr0>; Tue, 30 Oct 2001 11:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280015AbRJ3QrP>; Tue, 30 Oct 2001 11:47:15 -0500
Received: from beppo.feral.com ([192.67.166.79]:11013 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S280012AbRJ3QrF>;
	Tue, 30 Oct 2001 11:47:05 -0500
Date: Tue, 30 Oct 2001 08:47:14 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: "Ashish A. Palekar" <apalekar@trebia.com>
cc: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>,
        <linux-kernel@vger.kernel.org>
Subject: Re: iSCSI support for Linux
In-Reply-To: <3BDED5BD.33C546EB@trebia.com>
Message-ID: <20011030084427.X22458-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Tue, 30 Oct 2001, Ashish A. Palekar wrote:

> Nitin:
>
> The Target side does support 64 bit LUNs - as recommended by SAM-2. The
> SCSI Target Mid-level definition for a LUN is a u64. (Note: The SCSI
> Target Mid-Level is a completely different entity than the SCSI
> Initiator Mid-Level). The question that is up in the air is how to use
> those 64 bits for a good target representation.

IIRC the top 2 bits of the first byte of the 8 byte lun define the layout-
this is what you have to look at on the initiator side when you do a REPORT
LUNS command.

>
> The other thing is that 64 bit LUNs are __VERY_RARELY__ used in the SCSI
> world that I am familiar with. So unless you are in a highly specialized
> operation where all 64 bits are important to you, you can get by with 32
> bit LUNs.
>

I'm not sure I agree. As we move into more and more virtualization types of
enviroments, the full 64 bit WWPN is often used as the 'lun'. So while it is
true that it's not important now, I suspect in a couple of years it might be.


> On the Initiator side, the LUN issue also needs to be addressed by the
> SCSI Initiator Mid-Level. The person to speak to in this regard would be
> Eric Youngdale (eric@andante.org). In fact the LUN issue along with the
> scan code are some of things on the SCSI todo list - the scan thing
> being especially important if you are doing fibre channel to enable
> dynamic target discovery.
>
> Hope this helps
> Ashish
>
> Nitin Dhingra wrote:
> >
> > Ashish,
> >         I have seen your and other codes as well, I see that everybody's
> > used lun field as supplied by
> > middle layer right. No one is using 64-bit field acc. to SAM-2, but Linux
> > Scsi Subsystem doesn't support 64-bit
> > field it supports only 32-bit. Have you thought something about it and do
> > you have any solution to this?
> >
> > Kindly cc me as I am no longer in the mailing list.
> >
> > regards,
> > nitin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


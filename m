Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280005AbRJ3Qbp>; Tue, 30 Oct 2001 11:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280001AbRJ3Qb0>; Tue, 30 Oct 2001 11:31:26 -0500
Received: from [65.192.191.151] ([65.192.191.151]:50448 "EHLO lucy.trebia.com")
	by vger.kernel.org with ESMTP id <S280002AbRJ3QbT>;
	Tue, 30 Oct 2001 11:31:19 -0500
Message-ID: <3BDED5BD.33C546EB@trebia.com>
Date: Tue, 30 Oct 2001 11:30:53 -0500
From: "Ashish A. Palekar" <apalekar@trebia.com>
Organization: Trebia Networks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>, linux-kernel@vger.kernel.org
Subject: Re: iSCSI support for Linux
In-Reply-To: <7FADCB99FC82D41199F9000629A85D1A0293A56F@DCMTECHDOM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nitin:

The Target side does support 64 bit LUNs - as recommended by SAM-2. The
SCSI Target Mid-level definition for a LUN is a u64. (Note: The SCSI
Target Mid-Level is a completely different entity than the SCSI
Initiator Mid-Level). The question that is up in the air is how to use
those 64 bits for a good target representation.

The other thing is that 64 bit LUNs are __VERY_RARELY__ used in the SCSI
world that I am familiar with. So unless you are in a highly specialized
operation where all 64 bits are important to you, you can get by with 32
bit LUNs.

On the Initiator side, the LUN issue also needs to be addressed by the
SCSI Initiator Mid-Level. The person to speak to in this regard would be
Eric Youngdale (eric@andante.org). In fact the LUN issue along with the
scan code are some of things on the SCSI todo list - the scan thing
being especially important if you are doing fibre channel to enable
dynamic target discovery.

Hope this helps
Ashish

Nitin Dhingra wrote:
> 
> Ashish,
>         I have seen your and other codes as well, I see that everybody's
> used lun field as supplied by
> middle layer right. No one is using 64-bit field acc. to SAM-2, but Linux
> Scsi Subsystem doesn't support 64-bit
> field it supports only 32-bit. Have you thought something about it and do
> you have any solution to this?
> 
> Kindly cc me as I am no longer in the mailing list.
> 
> regards,
> nitin

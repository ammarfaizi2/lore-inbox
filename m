Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277385AbRJENtw>; Fri, 5 Oct 2001 09:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277383AbRJENtm>; Fri, 5 Oct 2001 09:49:42 -0400
Received: from www.microgate.com ([216.30.46.105]:10245 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S273506AbRJENtj>; Fri, 5 Oct 2001 09:49:39 -0400
Message-ID: <009701c14da4$9c87df10$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: <Telford002@aol.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <66.154deb31.28ee7185@aol.com>
Subject: Re: PCI Device Setup Question
Date: Fri, 5 Oct 2001 08:49:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joachim Martillo wrote:

> These cards use the PLX9050 PCI interface chip
...
> The cards are never masters and do no support
> PCI PREFETCH and if PCI transactions are made
> to them that relate to PCI PREFETCH, they become
> confused and hang.
...
> The PCI bus driver allocates the sab8253x registers
> as prefetchable memory resources.

The PCI9050 LAS0RR local configuration register
controls whether the address range is marked
prefetchable or not. If bit 3 is set, then the range is marked as
prefetchable in Bit 3 of PCI configuration register BAR2.

I would verify that the EEPROM attached to the PCI9050 is setup
to program the LAS0RR bit 3 to zero to mark the address range
as *not* supporting prefetch.

Paul Fulghum, paulkf@microgate.com
Microgate Corporation, www.microgate.com


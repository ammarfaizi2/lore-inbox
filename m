Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287959AbSABUro>; Wed, 2 Jan 2002 15:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287958AbSABUr2>; Wed, 2 Jan 2002 15:47:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58891 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287969AbSABUp4>;
	Wed, 2 Jan 2002 15:45:56 -0500
Message-ID: <3C337180.69561269@mandrakesoft.com>
Date: Wed, 02 Jan 2002 15:45:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102151539.A14925@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Is there any way to safely probe a PCI motherboard to determine whether
> or not it has ISA cards present, or ISA card slots?
> 
> Note: the question is *not* about a probe for whether the board has an ISA
> bridge, but a probe for the presence of actual ISA cards (or slots).

ISAPNP.  You can tell if ISA cards are present in some cases, but you
cannot tell when no ISA cards are present at all.

Further, serial and parallel devices are common examples of devices we
treat as ISA, which usually aren't.  They don't have a slot [usually]
but definitely need to be configured.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

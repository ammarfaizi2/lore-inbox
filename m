Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291091AbSBLOvI>; Tue, 12 Feb 2002 09:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291092AbSBLOu6>; Tue, 12 Feb 2002 09:50:58 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:39413 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S291091AbSBLOup>; Tue, 12 Feb 2002 09:50:45 -0500
From: <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <weber@nyc.rr.com>, <tom_gall@vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4, cs46xx snd, and virt_to_bus
Date: Tue, 12 Feb 2002 15:50:55 +0100
Message-Id: <20020212145055.24879@mailhost.mipsys.com>
In-Reply-To: <20020212144916.1889@mailhost.mipsys.com>
In-Reply-To: <20020212144916.1889@mailhost.mipsys.com>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I'd rather provide a function to obtain the base address of the ISA hole,
>while would also allow us to
> - Return an error when it doesn't exist (a given kernel may or may not
>have it depending on which box it's booted, it can't be a compile time
>option)
> - Eventually obtain a per-PCI bus ISA hole (the "legacy one" beeing
>defined as bus or with a special constant) so multi domain machines
>can use multiple VGA cards (eek eek ;)

Side note: even if we never intend to support multiple VGA cards in
separate domains, it still make sense to have a way to match an ISA
hole to it's hosting PCI bus (if any). The VGA card may not actually
be on the primary bus of a multiple-bus machine (and the very notion
of primary bus makes few sense in multi domain environements anyway)

Ben.




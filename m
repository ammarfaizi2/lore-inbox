Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267445AbTAGRGg>; Tue, 7 Jan 2003 12:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267446AbTAGRGe>; Tue, 7 Jan 2003 12:06:34 -0500
Received: from [195.208.223.236] ([195.208.223.236]:9088 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267445AbTAGRGc>; Tue, 7 Jan 2003 12:06:32 -0500
Date: Tue, 7 Jan 2003 20:12:29 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@cup.hp.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030107201229.D559@localhost.park.msu.ru>
References: <20030106215210.GE26790@cup.hp.com> <Pine.LNX.4.44.0301061515530.10086-100000@home.transmeta.com> <20030107001332.GJ26790@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030107001332.GJ26790@cup.hp.com>; from grundler@cup.hp.com on Mon, Jan 06, 2003 at 04:13:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 04:13:32PM -0800, Grant Grundler wrote:
> Turning off MASTER will also disable the controller from responding
> to MMIO ...ie USB subsystem can't touch the USB controller until
> it's re-enabled (no USB interrupts).

No, MMIO is controlled by PCI_COMMAND_MEMORY bit. We'll just turn
off DMA.

> I still have no idea which bridge implementations (vendor/model)
> have this problem and thus no idea what the i386 code would need 
> to look like. I was hoping Ivan (or someone) might know.

Perhaps it will be i386-specific "PCI_FIXUP_EARLY" routine which
turns of PCI_COMMAND_MASTER for all devices with a class code of
PCI_CLASS_SERIAL_USB.

Ivan.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267518AbTAGRWK>; Tue, 7 Jan 2003 12:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267517AbTAGRWK>; Tue, 7 Jan 2003 12:22:10 -0500
Received: from [195.208.223.236] ([195.208.223.236]:12160 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267518AbTAGRWJ>; Tue, 7 Jan 2003 12:22:09 -0500
Date: Tue, 7 Jan 2003 20:27:55 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grant Grundler <grundler@cup.hp.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030107202755.E559@localhost.park.msu.ru>
References: <20030106215210.GE26790@cup.hp.com> <Pine.LNX.4.44.0301061515530.10086-100000@home.transmeta.com> <20030107001332.GJ26790@cup.hp.com> <1041942820.20658.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 07, 2003 at 12:33:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 12:33:41PM +0000, Alan Cox wrote:
> > Did you expect the PCI_COMMAND_MASTER disabled in the USB Controller
> > or something else in the controller turned off?
> 
> There is another problem too. Some devices ignore the master bit disable.
> VIA 8233/8235 being a fine example.

I don't think IDE DMA is active at that point. But in either case,
with the 2-pass approach we should be able to handle 100% of
problematic hardware.

Ivan.

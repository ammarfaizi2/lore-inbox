Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbTAGLoA>; Tue, 7 Jan 2003 06:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267125AbTAGLoA>; Tue, 7 Jan 2003 06:44:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42630
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265589AbTAGLn7>; Tue, 7 Jan 2003 06:43:59 -0500
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Grant Grundler <grundler@cup.hp.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030107001332.GJ26790@cup.hp.com>
References: <20030106215210.GE26790@cup.hp.com>
	 <Pine.LNX.4.44.0301061515530.10086-100000@home.transmeta.com>
	 <20030107001332.GJ26790@cup.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Jan 2003 12:33:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 00:13, Grant Grundler wrote:
> On Mon, Jan 06, 2003 at 03:19:09PM -0800, Linus Torvalds wrote:
> > In particular, we can make the first phase disable DMA on the devices we 
> > find, which means that we know they won't be generating PCI traffic during 
> > the second phase - so now the second phase (which does the BAR sizing) can 
> > do sizing and be safe in the knowledge that there should be no random PCI 
> > activity ongoing at the same time.
> 
> Did you expect the PCI_COMMAND_MASTER disabled in the USB Controller
> or something else in the controller turned off?

There is another problem too. Some devices ignore the master bit disable.
VIA 8233/8235 being a fine example.


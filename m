Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319212AbSIKQRT>; Wed, 11 Sep 2002 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319209AbSIKQPs>; Wed, 11 Sep 2002 12:15:48 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:48887
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319212AbSIKQJZ>; Wed, 11 Sep 2002 12:09:25 -0400
Subject: Re: ignore pci devices?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Martin Mares <mj@ucw.cz>, Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020911153750.GA8649@bytesex.org>
References: <20020910134708.GA7836@bytesex.org>
	<20020910163023.GA3862@ucw.cz>
	<1031683362.1537.104.camel@irongate.swansea.linux.org.uk>
	<20020910184128.GA5627@ucw.cz>
	<1031688912.31787.129.camel@irongate.swansea.linux.org.uk>
	<20020911122048.GA6863@bytesex.org>
	<1031747880.2726.40.camel@irongate.swansea.linux.org.uk> 
	<20020911153750.GA8649@bytesex.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 11 Sep 2002 17:17:39 +0100
Message-Id: <1031761059.2768.68.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 16:37, Gerd Knorr wrote:
> guess you mean pci_assign_resource()?  Played with that one, now my
> /proc/iomem file looks *ahem* intresting.  Is this the bug mentioned
> above?

Well I've not seen it appear that way but I guess it could do - the old
code on finding a clash when reserving PCI resources (and you'll tickle
that anyway with pci_module_init and two candidate drivers) freed
resources it never allocated.

I'd have expected lots of printks first


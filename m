Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSIKM3x>; Wed, 11 Sep 2002 08:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSIKM3x>; Wed, 11 Sep 2002 08:29:53 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:52208
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317302AbSIKM3x>; Wed, 11 Sep 2002 08:29:53 -0400
Subject: Re: ignore pci devices?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Martin Mares <mj@ucw.cz>, Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020911122048.GA6863@bytesex.org>
References: <20020910134708.GA7836@bytesex.org>
	<20020910163023.GA3862@ucw.cz>
	<1031683362.1537.104.camel@irongate.swansea.linux.org.uk>
	<20020910184128.GA5627@ucw.cz>
	<1031688912.31787.129.camel@irongate.swansea.linux.org.uk> 
	<20020911122048.GA6863@bytesex.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 11 Sep 2002 13:38:00 +0100
Message-Id: <1031747880.2726.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 13:20, Gerd Knorr wrote:
> Neverless this works fine in the non-hotplugging modular driver case,
> i.e. it can be used to fix that particular bt878 card issue.  Might also
> be useful for testing ressource allocation error paths of PCI drivers.

Up until 2.4.20pre6 they are broken in the PCI core. IDE found that one
out.


The reserve module is an interesting approach though. I had been
pondering doing a rename module for some similar purposes but completely
missed that one.

BTW we have pci_request_resource stuff that would shrink your module a
fair bit


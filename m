Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264724AbUEPSK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264724AbUEPSK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbUEPSK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:10:28 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:61700 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S264724AbUEPSKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:10:23 -0400
Date: Sun, 16 May 2004 12:10:12 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Etienne Vogt <etienne.vogt@obspm.fr>, linux-kernel@vger.kernel.org
Subject: Re: aic79xx trouble
Message-ID: <3436150000.1084731012@aslan.btc.adaptec.com>
In-Reply-To: <Pine.LNX.4.58.0405161930260.2851@siolinb.obspm.fr>
References: <200405132125.28053.bernd.schubert@pci.uni-heidelberg.de> <200405132136.32703.bernd.schubert@pci.uni-heidelberg.de> <Pine.LNX.4.58.0405161930260.2851@siolinb.obspm.fr>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  The Adaptec Ultra320 cards (aic79xx) do not work reliably on Tyan Thunder
> motherboards.

The U320 chips likely work a lot better now if you use driver version 2.0.12.
The AMD chipsets seem to screw up split completions, and this version of
the driver avoids the issue for the most common case of triggering the
bug (transaction completion DMAs) by never crossing an ADB boundary with
a single DMA.

--
Justin


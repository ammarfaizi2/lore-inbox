Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264809AbTFWBxD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 21:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264831AbTFWBxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 21:53:03 -0400
Received: from [66.212.224.118] ([66.212.224.118]:41997 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S264809AbTFWBxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 21:53:01 -0400
Date: Sun, 22 Jun 2003 21:55:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] emu10k1 module in 2.5.72 oopses when being removed
In-Reply-To: <20030622120046.A21264@ss1000.ms.mff.cuni.cz>
Message-ID: <Pine.LNX.4.53.0306220950210.12131@montezuma.mastecende.com>
References: <20030622120046.A21264@ss1000.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Rudo Thomas wrote:

> I found out that the emu10k1 module in 2.5.72 oopses when being removed. I do
> believe it did something similar in 2.5.71, but can't confirm it now.
> 
> kernel-decoded oops report is attached, as is .config.

Call Trace:
 [<d09690f7>] +0x37/0xa0 [emu10k1]
 [<d096d348>] emu10k1_pci_driver+0x28/0xe0 [emu10k1]

Code:  Bad EIP value.

It appears the module got unloaded prematurely, is this the only modular 
PCI driver you have?

	Zwane
-- 
function.linuxpower.ca

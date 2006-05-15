Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWEOTBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWEOTBg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWEOTBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:01:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51167 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965150AbWEOTBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:01:32 -0400
To: <ravinandan.arakali@neterion.com>
Cc: "Peter. Phan" <peter.phan@neterion.com>,
       "Leonid Grossman" <Leonid.Grossman@neterion.com>,
       linux-kernel@vger.kernel.org
Subject: Re: MSI-X support on AMD 8132 platforms ?
References: <MAEEKMLDLDFEGKHNIJHIOECKCEAA.ravinandan.arakali@neterion.com>
	<MAEEKMLDLDFEGKHNIJHIKEIMCEAA.ravinandan.arakali@neterion.com>
From: Andi Kleen <ak@suse.de>
Date: 15 May 2006 21:01:21 +0200
In-Reply-To: <MAEEKMLDLDFEGKHNIJHIKEIMCEAA.ravinandan.arakali@neterion.com>
Message-ID: <p73hd3r5czi.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ravinandan Arakali" <ravinandan.arakali@neterion.com> writes:

> I was wondering if anybody has got MSI-X going on AMD 8132 platforms.
> Our network card and driver support MSI-X and the combination works
> fine on IA64 and xeon platforms. But on the 8132, the MSI-X vectors are
> assigned(pci_enable_msix succeeds) but no interrupts get generated.

See erratum #78 in the AMD 8132 Specification update.
It doesn't support the MSI capability and there are no plans to fix that.

AFAIK the only way to get MSI on Opteron is on PCI Express.

> Note that with a different OS, MSI-X does work on 8132.

Are you sure?

-Andi

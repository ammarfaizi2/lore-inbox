Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVFFLzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVFFLzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 07:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVFFLzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 07:55:50 -0400
Received: from isilmar.linta.de ([213.239.214.66]:18338 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261341AbVFFLzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 07:55:44 -0400
Date: Mon, 6 Jun 2005 13:55:42 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq/speedstep won't work on Sony Vaio PCG-F807K
Message-ID: <20050606115542.GA31947@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Prakash Punnoor <prakash@punnoor.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42935600.5090008@punnoor.de> <20050524203300.GA24187@isilmar.linta.de> <42939FAF.8040805@punnoor.de> <20050605172455.GH12338@dominikbrodowski.de> <42A42CA1.7080700@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A42CA1.7080700@punnoor.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 06, 2005 at 12:59:45PM +0200, Prakash Punnoor wrote:
> Thanx, now the module loads and (partly) works: I now have 500MHz and 650MHz
> *only* as selection and I can switch between them both. But why only this two
> options?

Because the CPU only offers these two states.

> If I enable speedstep in bios and force it, Linux reports 133MHz or
> alike as CPU speed,which seems to be a more realistic lower limit, as I don't
> think going to 500MHz will save me much.

However, the CPU only supports 500 MHz or 600 MHz. Possibly, the other
effect you're seeing is from CPU frequency throttling which is (mostly)
useless.

> Is there a possibility to get the ACPI P-state driver going? Perhaps this
> would give me a lower minimum clock. Or is the ACPI crew responsible for this
> driver and should I ask them?

The ACPI driver most likely would export the same two states. If it doesn't
work, it is (most likely) a BIOS issue [i.e. the BIOS only is ACPI
1.0-compliant and not 2.0] and not an ACPI issue.

	Dominik

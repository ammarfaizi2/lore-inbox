Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268878AbUHLW5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268878AbUHLW5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268871AbUHLWyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:54:52 -0400
Received: from fmr02.intel.com ([192.55.52.25]:46282 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S268859AbUHLWyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:54:03 -0400
Subject: Re: [ACPI] Re: Allow userspace do something special on overtemp
From: Len Brown <len.brown@intel.com>
To: stefandoesinger@gmx.at
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@suse.cz>, trenn@suse.de, seife@suse.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408121927.11277.stefandoesinger@gmx.at>
References: <20040811085326.GA11765@elf.ucw.cz>
	 <1092323945.5028.177.camel@dhcppc4>
	 <200408121927.11277.stefandoesinger@gmx.at>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1092351206.5021.201.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 12 Aug 2004 18:53:27 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 13:27, Stefan Dösinger wrote:
> Hi,
> Isn't this a little bit dangerous? What if acpid is not set up to
> handle this?
> 

There are two levels of hardware thermal control that will
kick in -- TM1 and TM2, and if they fail the hardware will
turn itself off.  Speaking for Intel processors only.

The reason is that the hardware needs to handle this case
where the OS crashes while in ACPI mode and is unable
to do any thermal control itself.

cheers,
-Len



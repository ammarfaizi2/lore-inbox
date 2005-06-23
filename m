Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbVFWIIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVFWIIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVFWIFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:05:16 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:36286 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262455AbVFWGZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:25:29 -0400
Message-ID: <42BA55D2.7020900@ens-lyon.org>
Date: Thu, 23 Jun 2005 08:25:22 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-mm1
References: <20050619233029.45dd66b8.akpm@osdl.org> <42B6746B.4020305@ens-lyon.org> <20050620081443.GA31831@isilmar.linta.de> <42B6831B.3040506@ens-lyon.org> <20050620085449.GA32330@isilmar.linta.de> <42B6C06F.4000704@ens-lyon.org> <20050622163427.A10079@unix-os.sc.intel.com>
In-Reply-To: <20050622163427.A10079@unix-os.sc.intel.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23.06.2005 01:34, Rajesh Shah a écrit :
> On Mon, Jun 20, 2005 at 03:11:11PM +0200, Brice Goglin wrote:
> 
>>Dominik Brodowski a écrit :
>>
>>>Did you modify the .config in between?
>>
>>I just checked carrefully which versions do work.
>>It seems that this breakage appeared in rc6-mm1 with the same
>>config than a working rc5-mm2.
> 
> 
> Can you revert gregkh-pci-pci-collect-host-bridge-resources-02.patch
> from the broken-out patches for 2.6.12-mm1 and see if the problem
> goes away? If yes, it could be that the ACPI firmware on this
> system is not reporting proper host bridge resources, and all
> downstream device resources get messed up..

You're right. I reverted this one two days ago and got a working
system. Actually, the system had other problems (got an oops when
reading /proc/ioports). But they might be caused by dependencies
between Grekgh's PCI patches that were still applied and and the
one I removed, right ?
Anyway, this fixed my maestro3 divide error and the yenta hang
during boot.

Brice

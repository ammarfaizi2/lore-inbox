Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270614AbTGTDnL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 23:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270615AbTGTDnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 23:43:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7893 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270614AbTGTDnK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 23:43:10 -0400
Message-ID: <3F1A1345.7080301@pobox.com>
Date: Sat, 19 Jul 2003 23:57:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Reppert <repp0017@tc.umn.edu>
CC: Pedro Ribeiro <deadheart@netcabo.pt>, linux-kernel@vger.kernel.org
Subject: Re: Problem with mii-tool && 2.6.0-test1-ac2
References: <3F198C66.1030405@netcabo.pt> <20030719232804.08cc3689.repp0017@tc.umn.edu>
In-Reply-To: <20030719232804.08cc3689.repp0017@tc.umn.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Reppert wrote:
> On Sat, 19 Jul 2003 19:22:30 +0100
> Pedro Ribeiro <deadheart@netcabo.pt> wrote:
> 
> 
>>If I compile the 8139 ethernet support as a module (as I always did - 
>>module name >> 8130too) I will get an error in make modules_install. 
>>However, if I build it in the kernel it will work just fine. The problem 
>>is that now when I try to do a simple mii-tool -F 100baseTX-FD eth0 
>>(because my eth always stats at 100 Half duplex) I get this error:
>>
>>SIOCGMIIPHY on 'eth0' failed: Operation not supported
> 
> 
> What's the error you get on install? I don't have a problem doing it on
> my iBook.
> 
> You have to explicitly turn on MII support in 2.6-test; the kconfig option
> is CONFIG_MII; it's "Generic Media Independent Interface device support",
> the first item under "Ethernet (10 or 100Mbit)". This needs to be modular or
> on to use mii-tool, I imagine.


No, CONFIG_MII only occasionally affects mii-tool support.  Further, 
CONFIG_MII is forced on if it is needed.

As I explained in another mail, older mii-tool binaries use the 
traditional -- but non-standard -- ioctls for the MII operations.  Newer 
versions of mii-tool use the proper SIOC[GS]MIIxxx ioctls.

The proper fix is to obtain the latest version of mii-tool, possibly 
from net-utils cvs if nowhere else.

	Jeff




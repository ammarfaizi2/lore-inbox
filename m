Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264505AbUFGNr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUFGNr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUFGNr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 09:47:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60599 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264505AbUFGNry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 09:47:54 -0400
Message-ID: <40C471FC.3000802@pobox.com>
Date: Mon, 07 Jun 2004 09:47:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       perex@suse.cz, torvalds@osdl.org
Subject: Re: [RFC] ASLA design, depth of code review and lack thereof
References: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk>	<40C107D2.9030301@pobox.com> <s5hekor4i2c.wl@alsa2.suse.de>
In-Reply-To: <s5hekor4i2c.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> At Fri, 04 Jun 2004 19:37:54 -0400,
> Jeff Garzik wrote:
> 
>>
>>While we're bitching about ALSA, can we please kill the 
>>subsystem-specific malloc and "magic cast" wrappers?
>>This debug machinery is better done elsewhere...
> 
> 
> Of course we can remove kmalloc/vmalloc wrappers for cast checking
> once when the kernel core provides a similar debugging mechanism.
> Do you know any alternative?


CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC.  Other stuff should go 
into ALSA developer trees or use of a debugger, not be in mainline 
kernel code.

	Jeff



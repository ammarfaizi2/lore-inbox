Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWGWNq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWGWNq6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 09:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWGWNq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 09:46:58 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:1409 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1751215AbWGWNq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 09:46:58 -0400
Message-ID: <44C37DCF.2080205@bootc.net>
Date: Sun, 23 Jul 2006 14:46:55 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Eric Lammerts <eric@lammerts.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, soekris-tech@lists.soekris.com
Subject: Re: [RFC][PATCH] LED Class support for Soekris net48xx
References: <44AF7B00.9060108@bootc.net> <44C2EB45.1050302@lammerts.org>
In-Reply-To: <44C2EB45.1050302@lammerts.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Lammerts wrote:
> Chris Boot wrote:
>> I'd love to find a way of detecting a Soekris net48xx device
>  > but there is no DMI or any Soekris-specific PCI devices.
> 
> You could do ugly things like this:
> 
>         int i;
>         char *bios = __va(0xf0000);
> 
>         for(i = 0; i < 0x10000 - 19; i++) {
>                 if(memcmp(bios + i, "Soekris Engineering", 19) == 0) {
>                         printk("soekris string found at 0x%x\n", i);
>                 }
>         }
> 
> The string "net4801" is also in there (although I'm using a 4826).
> 
> If anyone knows a better way, I'd like to know it too.

Hmm, very ugly indeed! Where did you dig those offsets up from? Are they likely 
to work properly in non-Soekris devices? I think just relying on people not 
loading the module when not in the correct hardware is probably the best option 
at the moment...

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/

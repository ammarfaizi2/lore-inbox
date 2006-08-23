Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWHWVBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWHWVBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWHWVBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:01:48 -0400
Received: from ns.sitour.cz ([212.158.149.14]:23546 "EHLO kali.sitour.cz")
	by vger.kernel.org with ESMTP id S965035AbWHWVBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:01:47 -0400
Message-ID: <44ECC22E.50206@mydatex.cz>
Date: Wed, 23 Aug 2006 23:01:34 +0200
From: Daniel Smolik <marvin@mydatex.cz>
Organization: Mydatex s.r.o.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; cs-CZ; rv:1.7.8) Gecko/20060628 Debian/1.7.8-1sarge7.1
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: sym53c8xx PCI card broken in 2.6.18
References: <200608221546.11532.dj@david-web.co.uk>
In-Reply-To: <200608221546.11532.dj@david-web.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Johnson napsal(a):
> Hi all,
> 
> I'm running a Sun Ultra Enterprise 450 (SPARC64) machine which has an on-board 
> SCSI controller and a PCI SCSI controller, both supported by the sym53c8xx 
> driver.
> 
> With 2.6.17.9 (and earlier) SCSI works perfectly, but with 2.6.18-rc4 and 
> 2.6.18-rc4-git1 I'm getting errors on boot for all devices attached to the 
> PCI card, but all the devices attached to the on-board controller are 
> detected and configured OK.
> 
> lspci identifies the on-board controller as:
> SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 03)
> and the PCI controller as:
> SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
> 
> Here's the output from initialisation of the devices on the PCI card (repeated 
> for every device):
> scsi2: sym-2.2.3
> scsi 2:0:0:0 ABORT operation started
> scsi 2:0:0:0 ABORT operation timed out
> scsi 2:0:0:0 DEVICE RESET operation started
> scsi 2:0:0:0 DEVICE RESET operation timed out
> scsi 2:0:0:0 BUS RESET operation started
> scsi 2:0:0:0 BUS RESET operation timed out
> scsi 2:0:0:0 HOST RESET operation started
> sym2: SCSI bus has been reset
> scsi 2:0:0:0 HOST RESET operation timed out
> scsi: device offlined - not ready after error recovery
> 
> The devices on the PCI controller are a mixture of 'Fujitsu MAG3182L SUN18G' 
> and 'Seagate ST318203LSUN18G' drives.
> 
> Looking through the changelogs between 2.6.17.9 and 2.6.18-rc4-git1, I can't 
> see any changes to sym53c8xx, so I'm guessing this has been caused by some 
> generic SCSI subsystem change. Let me know if I can do any more to debug.
> 
> Regards,
> David.
>   
I must say that I have the same   experience with E250 a D1000 disk array.
I think that is  HW problem but I have the same symptom described before.
If I have disk in internal bay and controller all works perfect. But if I put 
disk to D1000 I get the same error. I have use 2.6.18-rc3.

			Dan

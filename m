Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263273AbVGOLxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbVGOLxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbVGOLxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:53:43 -0400
Received: from imap.gmx.net ([213.165.64.20]:40361 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263275AbVGOLxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:53:06 -0400
X-Authenticated: #26200865
Message-ID: <42D7A3D1.5080609@gmx.net>
Date: Fri, 15 Jul 2005 13:53:53 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Bas Vermeulen <bvermeul@blackstar.nl>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ATAPI+SATA support in 2.6.13-rc3
References: <42D78269.5020809@gmx.net> <1121421557.5110.11.camel@laptop.blackstar.nl>
In-Reply-To: <1121421557.5110.11.camel@laptop.blackstar.nl>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bas Vermeulen schrieb:
> On Fri, 2005-07-15 at 11:31 +0200, Carl-Daniel Hailfinger wrote:
> 
>>Hi Jeff,
>>
>>I have a Intel ICH6M chipset and am using ata_piix as my
>>default disk driver. With the SUSE patched 2.6.11.4 kernel
>>(it has some libata patches) my DVD-RAM drive works, with
>>2.6.13-rc3 it doesn't work. My .config is nearly identical
>>for both kernels (except options introduced after 2.6.11).
>>
>>I have two suspects: the changed interrupt routing and
>>libata version differences. Especially strange is the fact
>>that both kernels seem to disagree with lspci about the
>>interrupts assigned to the SATA controller.
>>
>>Please find dmesg, /proc/interrupts and lspci -v attached
>>for both kernels.
>>
>>Regards,
>>Carl-Daniel
> 
> 
> You'll need to enable ATAPI support for ata_piix in
> include/linux/libata.h
> 
> Change:
> #undef ATA_ENABLE_ATAPI
> 
> into
> #define ATA_ENABLE_ATAPI
> 
> Suse has probably done that for you, it's disabled by default.

Thanks, I'll try that.

Are there any unmerged (in 2.6.13-rc3) libata patches and
where can I find them?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

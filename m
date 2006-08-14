Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWHNNbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWHNNbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 09:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWHNNbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 09:31:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:63259 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751312AbWHNNbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 09:31:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dyj+MGnRQEA5q00FUg9Ob86a3tkgXLmlvgTioiek8Vi1nFSjFF7EUZRVQ7WOar+KlSvfs4mxFYCfNz8/VMgXgEfyUmYTzIpj2e5RRsKTn20k0LFhv8oDUFWr0XXVFlc29iLlwqVnkzdNLFMG/arrdlWbf0Jmtb3pV08Kssl5uyQ=
Message-ID: <44E07B36.6070508@gmail.com>
Date: Mon, 14 Aug 2006 15:31:11 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel panic - not syncing: VFS - unable to mount root fs on
 unknown-block
References: <44DFCF20.9030202@wanadoo.fr>
In-Reply-To: <44DFCF20.9030202@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hulin Thibaud wrote:
> Hello !
> I'm trying to compile my own kernel for drivers on two computers, but 
> that fails. A the boot, I have this error :
> kernel panic - not syncing: VFS Unable to mount root fs on unknow-block 
> (3.69)
> 
> I'm using the kernel 2.6.19 with Ubuntu Dapper. I use the old boot 

Wow, 2.6.18 wasn't released yet and you have 2.6.19, cool.

> config and I type make oldconfig, so I don't understand why there are an 
> error with the near same configuration.
> I suppose that I must compile not in module but in hard support for my 
> IDE chipset, harddisk and file system. Probably, I don't understand how 
> do exactly. I do that :
> lspci |grep IDE
> 0000:00:11.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> make xconfig
> -Device Drivers
> --* ATA/ATAPI/MFM/RLL support
> --- * Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support
> --- * Include IDE/ATA-2 DISK support
> --- * PCI IDE chipset support
> ---- * Generic PCI IDE Support
> ----- * VIA82CXXX chipset support
> - File systems
> -- * Ext3 journalling file system support
> --- * Ext3 extended attributes
> ---- * Ext3 POSIX Access Control Lists
> ---- * Ext3 Security Labels
> 
> Have I forgot anything ?

RAID or LVM? Try initrd.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUG2NCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUG2NCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 09:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUG2NCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 09:02:49 -0400
Received: from [195.23.16.24] ([195.23.16.24]:58056 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264524AbUG2NCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 09:02:48 -0400
Message-ID: <4108F574.4000300@grupopie.com>
Date: Thu, 29 Jul 2004 14:02:44 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grega Fajdiga <Gregor.Fajdiga@guest.arnes.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile error in 2.6.8-rc2-mm1 - rivafb related
References: <1091105305.11537.6.camel@cable155-82.ljk.voljatel.net>
In-Reply-To: <1091105305.11537.6.camel@cable155-82.ljk.voljatel.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.50; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grega Fajdiga wrote:
> ...
> 
> Config attached. BTW why can't I disable SCSI support in menuconfig? I 
> don't really need it.

probably because of this in "drivers/usb/storage/Kconfig":

 > config USB_STORAGE
 > 	tristate "USB Mass Storage support"
 > 	depends on USB
 > 	select SCSI

USB storage depends on SCSI. So, if you have usb-storage support you 
can't unselect SCSI.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

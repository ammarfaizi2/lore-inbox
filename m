Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTEMSIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTEMSGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:06:37 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:40721 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261669AbTEMSFR (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:05:17 -0400
Date: Tue, 13 May 2003 20:18:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Riley Williams <Riley@Williams.Name>
Cc: Linux Kernel List <Linux-Kernel@vger.kernel.org>
Subject: Re: Pristine 2.5.69 warnings for make defconfig
Message-ID: <20030513181802.GC1170@mars.ravnborg.org>
Mail-Followup-To: Riley Williams <Riley@Williams.Name>,
	Linux Kernel List <Linux-Kernel@vger.kernel.org>
References: <BKEGKPICNAKILKJKMHCAOEGPCPAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEGKPICNAKILKJKMHCAOEGPCPAA.Riley@Williams.Name>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:16:20PM +0100, Riley Williams wrote:
>  Q> kernel/ksyms.c:453: warning: `__check_region' is deprecated
>  Q>				(declared at include/linux/ioport.h:113)
>  453>	EXPORT_SYMBOL(__check_region);
Some modules still needs it - so it is exported.
People will ruin them out as time passes.

>  Q> include/asm/string.h:145: warning: `strchr' defined but not used
This I cannot explain - it should not happen. Oleg at some point asked
if this was a compiler bug. Anyone?

>  Q> drivers/scsi/qla1280.c:5948: warning:
>  Q>		initialization from incompatible pointer type
>  Q> drivers/scsi/qla1280.c:5948: warning:
>  Q>		initialization from incompatible pointer type
Which tell you that this driver is not converted to use the new error handling.

	Sam

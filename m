Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVKWAyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVKWAyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVKWAyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:54:31 -0500
Received: from fmr23.intel.com ([143.183.121.15]:32669 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030286AbVKWAya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:54:30 -0500
Date: Tue, 22 Nov 2005 16:54:29 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: BUG 2.6.14.2 : ACPI boot lockup
Message-ID: <20051122165429.A30362@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20051122211947.GA29622@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051122211947.GA29622@bougret.hpl.hp.com>; from jt@hpl.hp.com on Tue, Nov 22, 2005 at 01:19:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 01:19:47PM -0800, Jean Tourrilhes wrote:
> 	Hi Rajesh,
> 
> 	I have some ACPI trouble, and one of your checkin may be
> related to it. Would you mind checking the following LKML thread ?
> 	http://marc.theaimsgroup.com/?t=113268687800002&r=1&w=2
> 
Thanks for pointing me here, I wasn't reading this thread...
Does this patch help?

thanks,
Rajesh


 drivers/acpi/scan.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.14-vanilla/drivers/acpi/scan.c
===================================================================
--- linux-2.6.14-vanilla.orig/drivers/acpi/scan.c
+++ linux-2.6.14-vanilla/drivers/acpi/scan.c
@@ -1111,7 +1111,7 @@ acpi_add_single_object(struct acpi_devic
 	 *
 	 * TBD: Assumes LDM provides driver hot-plug capability.
 	 */
-	result = acpi_bus_find_driver(device);
+	acpi_bus_find_driver(device);
 
       end:
 	if (!result)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVEETkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVEETkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVEETjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:39:44 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:49609 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262184AbVEETKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:10:48 -0400
Date: Thu, 5 May 2005 14:10:03 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: akpm@osdl.org
cc: jgarzik@pobox.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH: 3 of 12] Fix TPM driver --remove unnecessary module stuff 
Message-ID: <Pine.LNX.4.62.0505051326330.5303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply these fixes to the Tpm driver.  I am resubmitting the entire
patch set that was orginally sent to LKML on April 27 with the changes
that were requested fixed.

Thanks,
Kylie

On Wed, 9 Mar 2005, Jeff Garzik wrote:
> Greg KH wrote:

<snip>

> > +
> > +static int __init init_tpm(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void __exit cleanup_tpm(void)
> > +{
> > +
> > +}
> > +
> > +module_init(init_tpm);
> > +module_exit(cleanup_tpm);
> 
> why?  just delete these, I would say.
> 

<snip>

No reason for these module definitions.  This patch removes them.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc2/drivers/chat/tpm/tpm.c	2005-04-21 17:45:30.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-21 17:36:59.000000000 -0500
@@ -668,19 +668,6 @@ dev_num_search_complete:
 
 EXPORT_SYMBOL_GPL(tpm_register_hardware);
 
-static int __init init_tpm(void)
-{
-	return 0;
-}
-
-static void __exit cleanup_tpm(void)
-{
-
-}
-
-module_init(init_tpm);
-module_exit(cleanup_tpm);
-
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
 MODULE_DESCRIPTION("TPM Driver");
 MODULE_VERSION("2.0");

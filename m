Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVD0WSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVD0WSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVD0WQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:16:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:38275 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262054AbVD0WQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:16:21 -0400
Date: Wed, 27 Apr 2005 17:16:08 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH: 3 of 12] Fix TPM driver --remove unnecessary module stuff
In-Reply-To: <422FC42B.7@pobox.com>
Message-ID: <Pine.LNX.4.61.0504271432491.3929@jo.austin.ibm.com>
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

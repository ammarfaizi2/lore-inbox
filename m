Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVCNSLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVCNSLj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVCNSI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:08:29 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:55235 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261661AbVCNSEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:04:14 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [patch 01/14] char/snsc: reorder set_current_state() and add_wait_queue()
Date: Mon, 14 Mar 2005 10:03:59 -0800
User-Agent: KMail/1.7.2
Cc: domen@coderock.org, ghoward@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20050306223616.C82751EC90@trashy.coderock.org> <200503140945.44323.jbarnes@engr.sgi.com> <20050314175427.GA2993@us.ibm.com>
In-Reply-To: <20050314175427.GA2993@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PIdNCHbDC+6q6LF"
Message-Id: <200503141003.59618.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PIdNCHbDC+6q6LF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday, March 14, 2005 9:54 am, Nishanth Aravamudan wrote:
> On Mon, Mar 14, 2005 at 09:45:44AM -0800, Jesse Barnes wrote:
> > On Sunday, March 6, 2005 2:36 pm, domen@coderock.org wrote:
> > > Any comments would be, as always, appreciated.
> >
> > I don't have a problem with this change, but the maintainer probably
> > should have been Cc'd.  Greg, does this change look ok to you?  Note that
> > it's already been committed to the upstream tree, so if it's a bad change
> > we'll need to have the cset excluded or something.
>
> Thanks for the feedback. I don't see a maintainer entry for Greg
> anywhere in the snsc.{c,h} files or MAINTAINERS. Could someone throw a
> patch upstream so that whomever should be contacted for this driver will
> be in the future?

Good point :)  I assumed there was a MODULE_AUTHOR entry.  Here's a patch to 
get Greg more spam^W^W^W^Wadd the relevant info.  Look ok to you Greg?

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Jesse


--Boundary-00=_PIdNCHbDC+6q6LF
Content-Type: text/plain;
  charset="iso-8859-1";
  name="snsc-author.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snsc-author.patch"

===== drivers/char/snsc.c 1.4 vs edited =====
--- 1.4/drivers/char/snsc.c	2005-03-13 15:30:07 -08:00
+++ edited/drivers/char/snsc.c	2005-03-14 10:01:38 -08:00
@@ -28,6 +28,10 @@
 #include <asm/sn/nodepda.h>
 #include "snsc.h"
 
+MODULE_AUTHOR("Greg Howard <ghoward@sgi.com>");
+MODULE_DESCRIPTION("SGI System Controller driver");
+MODULE_LICENSE("GPL");
+
 #define SYSCTL_BASENAME	"snsc"
 
 #define SCDRV_BUFSZ	2048

--Boundary-00=_PIdNCHbDC+6q6LF--

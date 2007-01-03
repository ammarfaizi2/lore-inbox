Return-Path: <linux-kernel-owner+w=401wt.eu-S1751063AbXACS7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbXACS7R (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 13:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbXACS7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 13:59:17 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:44668 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbXACS7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 13:59:16 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 3 Jan 2007 18:58:57 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Arjan van de Ven <arjan@infradead.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] Export invalidate_mapping_pages() to modules.
In-Reply-To: <1167830972.3095.3.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0701031857360.14663@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0701012322050.1218@hermes-1.csi.cam.ac.uk>
 <1167830972.3095.3.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2007, Arjan van de Ven wrote:
> On Mon, 2007-01-01 at 23:28 +0000, Anton Altaparmakov wrote:
> > Hi Linus and Andrew,
> > 
> > Please apply below patch which exports invalidate_mapping_pages() to 
> > modules.  It makes no sense to me to export invalidate_inode_pages() and 
> > not invalidate_mapping_pages() and I actually need 
> > invalidate_mapping_pages() because of its range specification ability...
> > 
> > It would be great if this could make it into 2.6.20!
> 
> yet.. if there's not a single user it makes the kernel binary 100 to 150
> bytes bigger in memory......  

Well I call it from two different places but the code is not in the kernel 
(yet)...  Also the way Andrew has added this to -mm it does not use the 
extra space as you say because he added the export as per my patch but 
then removed the export for invalidate_inode_pages() and turned that into 
a static inline instead.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/

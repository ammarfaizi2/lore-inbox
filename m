Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266744AbUGUV0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266744AbUGUV0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUGUV0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:26:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62960 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266738AbUGUV03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:26:29 -0400
Date: Wed, 21 Jul 2004 16:26:21 -0500
To: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org,
       paulus@samba.org, paulus@au1.ibm.com
Cc: linas@linas.org
Subject: Remail: [PATCH] 2.6 PPC64: PCI Config Space reads need EEH checking
Message-ID: <20040721212621.GZ13171@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's another patch that was blocked by the email gateways.

--linas


----- Forwarded message from Mail Delivery System <Mailer-Daemon@bilge> -----
------ This is a copy of the message, including all the headers. ------

Return-path: <linas@bilge>
Received: from linas by bilge with local (Exim 3.36 #1 (Debian))
	id 1Bj4LA-0005nR-00; Fri, 09 Jul 2004 17:59:36 -0500
Date: Fri, 9 Jul 2004 17:59:36 -0500
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 PPC64: PCI Config Space reads need EEH checking
Message-ID: <20040709225936.GH17333@bilge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@bilge>


Paul,

This patch adds explicit checking for EEH slot isolation events into the 
PCI config space read path.  The change itself would have been minor,
except that pci config reads don't have a pointer to a struct pci_dev.
Thus, I had to restructure the eeh code to accomodate this, which
seems to be a good thing anyway, making it a tad cleaner.   This patch
presumes the earlier patches i.e. the notifier-call chain patch) have
been applied.

Please forward upstream if all's OK.

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas 

----- End forwarded message -----

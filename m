Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbUKDPqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbUKDPqX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbUKDPqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:46:23 -0500
Received: from ozlabs.org ([203.10.76.45]:37760 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262271AbUKDPpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:45:52 -0500
Date: Fri, 5 Nov 2004 02:43:17 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, herbert@gondor.apana.org.au, greg@kroah.com,
       rml@ximian.com
Subject: netlink vs kobject_uevent ordering
Message-ID: <20041104154317.GA1268@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I noticed kobject_uevent was failing to init on my box. It looks like
both netlink and kobject_uevent are marked core_initcall and we may not
do them in the correct order.

I guess the recent changes to netlink caused this:

http://linux.bkbits.net:8080/linux-2.5/cset@41896b1dIiNgXpwhgimeurIqPpofbw?nav=index.html|ChangeSet@-2d

Anton

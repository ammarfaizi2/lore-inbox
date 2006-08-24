Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWHXSRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWHXSRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWHXSRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:17:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:31424 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751635AbWHXSRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:17:23 -0400
Date: Thu, 24 Aug 2006 13:17:22 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: mhalcrow@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] eCryptfs: Public key support
Message-ID: <20060824181722.GA17658@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This first two patches in this patch set introduce public key support
into the eCryptfs kernel module shipping in 2.6.18-rc4-mm2. The last
two patches clean up the flag manipulation code and resolve a compiler
warning.

The userspace code that supports the public key mode of operation is
available in the file labeled
``ecryptfs-util-2.6.18-rc4-mm2++.tar.bz2'':

http://sourceforge.net/project/showfiles.php?group_id=133988&package_id=149785

Notice that the version numbers are incremented; the userspace tools
must be upgraded when running with this patch set. Follow the file
migration instructions in the NOTES section of
Documentation/ecryptfs.txt.

On open of an existing encrypted file, eCryptfs reads the public key
packet from the file header and sends a decrypt request packet via
netlink to the user's daemon. If the file is being created, eCryptfs
sends an encrypt request. The daemon processes the request through the
pluggable PKI module associated with the public key involved in the
request.

For those who wish to try out eCryptfs on older kernels, we are also
keeping backports of eCryptfs in packages under the ``ecryptfs-full''
release section:

http://sourceforge.net/project/showfiles.php?group_id=133988&package_id=198555

Mike

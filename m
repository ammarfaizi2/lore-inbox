Return-Path: <linux-kernel-owner+w=401wt.eu-S932442AbXAIWVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbXAIWVL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbXAIWVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:21:11 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:37206 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442AbXAIWVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:21:10 -0500
Date: Tue, 9 Jan 2007 16:21:07 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, tshighla@us.ibm.com, theotso@us.ibm.com,
       mhalcrow@us.ibm.com
Subject: [PATCH 0/3] eCryptfs: Support metadata in xattr
Message-ID: <20070109222107.GC16578@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces the ability to store cryptographic metadata
into an lower file extended attribute rather than the lower file
header region.

This patch set implements two new mount options:

ecryptfs_xattr_metadata
 - When set, newly created files will have their cryptographic
   metadata stored in the extended attribute region of the file rather
   than the header.

ecryptfs_encrypted_view
 - When set, this option causes eCryptfs to present applications a
   view of encrypted files as if the cryptographic metadata were
   stored in the file header, whether the metadata is actually stored
   in the header or in the extended attributes.

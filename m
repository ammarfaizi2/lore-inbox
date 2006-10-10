Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWJJS1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWJJS1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWJJS1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:27:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:6366 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965060AbWJJS1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:27:20 -0400
From: Chandra Seetharaman <sekharan@us.ibm.com>
To: akpm@osdl.org, Joel.Becker@oracle.com
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       linux-kernel@vger.kernel.org
Date: Tue, 10 Oct 2006 11:20:43 -0700
Message-Id: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
Subject: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, maximum amount of data that can be read from a configfs
attribute file is limited to PAGESIZE bytes. This is a limitation for
some of the usages of configfs.

This patchset removes that limitaion by using seq_file for read operations
instead of using locally allocated buffer.

Tested the interface change with configfs_example.c in the Documentation
directory.

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVIIIp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVIIIp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVIIIp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:45:56 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:51372 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751441AbVIIIpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:45:55 -0400
Date: Fri, 9 Sep 2005 17:42:14 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com,
       ext3-users@redhat.com
Subject: [PATCH 0/6] jbd cleanup
Message-ID: <20050909084214.GB14205@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following 6 patches cleanup the jbd code and kill about 200 lines. 
First of 4 patches can apply to 2.6.13-git8 and 2.6.13-mm2.
The rest of them can apply to 2.6.13-mm2.

 fs/jbd/checkpoint.c          |  179 +++++++++++--------------------------------
 fs/jbd/commit.c              |  101 ++++++++++--------------
 fs/jbd/journal.c             |   11 +-
 fs/jbd/revoke.c              |  158 ++++++++++++++-----------------------
 fs/jbd/transaction.c         |  113 +++++----------------------
 include/linux/jbd.h          |   28 +++---
 include/linux/journal-head.h |    4 
 7 files changed, 201 insertions(+), 393 deletions(-)

